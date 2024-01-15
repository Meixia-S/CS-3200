from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Research_Archive = Blueprint('Research_Archive', __name__)

# Get all the products from the database
@Research_Archive.route('/Research_Archive/<name>', methods=['GET'])
def get_research_archives(name):
        # get a cursor object from the database
    cursor = db.get_db().cursor()

    query = 'SELECT name, collections, area, siteID\n'
    query += ' FROM Research_Archive\n'
    query += ' WHERE Research_Archive.name = ' + str(name)

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

    return jsonify(json_data)