from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Airline = Blueprint('Airline', __name__)

# Get all the products from the database
@Airline.route('/Airline/<airlineID>', methods=['GET'])
def get_airline_rating(airlineID):
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT airlineID, name, reliabilityRating FROM Airline where airlineID = ' + str(airlineID)

    # WHERE airlineID = %s
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