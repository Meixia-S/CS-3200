from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Secondary_Traveler = Blueprint('Secondary_Traveler', __name__)

# Get all the products from the database
@Secondary_Traveler.route('/Secondary_Traveler/<customerID>', methods=['GET'])
def get_secondary_travelers(customerID):
    # get a cursor object from the databas
    cursor = db.get_db().cursor()
    query = 'SELECT st.travelerID, st.firstName, st.lastName, st.customerID, c.firstName, c.lastName\n'
    query += ' FROM Customer c JOIN Secondary_Traveler st ON c.customerID = st.customerID\n'
    query += ' WHERE st.customerID = ' + str(customerID)
    # query = 'SELECT st.travelerID, st.firstName, st.lastName, st.customerID, c.firstName, c.lastName\n'
    # query += ' FROM Secondary_Traveler st JOIN Customer c ON c.customerID = st.customerID\n'
    # query += ' WHERE st.customerID = ' + str(customerID)

    # use cursor to query the database for a list of products
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

    return the_response