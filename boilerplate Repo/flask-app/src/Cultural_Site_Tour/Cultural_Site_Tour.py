from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Cultural_Site_Tour = Blueprint('Cultural_Site_Tour', __name__)

# Get all the products from the database
@Cultural_Site_Tour.route('/Cultural_Site_Tour/<tourID>', methods=['GET'])
def get_cultural_site_on_tours(tourID):

    # get a cursor object from the database
    cursor = db.get_db().cursor()

    query = 'SELECT cst.tourID, cst.siteID, cs.name, cs.type, cs.zip, cs.street, cs.city, cs.state\n'
    query += ' FROM Cultural_Site_Tour cst JOIN Cultural_Site cs ON cst.siteID = cs.siteID\n'
    query += ' WHERE cst.tourID = ' + str(tourID)
    
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