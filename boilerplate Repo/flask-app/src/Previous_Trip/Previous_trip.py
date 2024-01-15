from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Previous_Trip = Blueprint('Previous_Trip', __name__)

# Get all the products from the database
@Previous_Trip.route('/Previous_Trip/<customerID>', methods=['GET'])
def get_previous_trip_information(customerID):

    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT *\n'
    query += ' FROM Previous_Trip pt JOIN Customer ON pt.customerID = Customer.customerID\n'
    query += ' WHERE pt.customerID = ' + str(customerID)
    
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

@Previous_Trip.route('/Previous_Trip/<tripID>', methods=['PUT'])
def update_representative_information(tripID):
    # Parse the JSON data from the request
    data = request.get_json()

    # Check if the required fields are present in the request data
    if 'itineraryDoc' not in data :
        return jsonify({'error': 'Missing required fields'}), 400
#or 'duration' not in data or 'cost' not in data
    # Extract data from the request
    itineraryDoc = data['itineraryDoc']
    duration = data['duration']
    cost = data['cost']

    current_app.logger.info(data)
  
    # use cursor to update the representative information in the database
    query = 'UPDATE Previous_Trip SET itineraryDoc = ' + str(itineraryDoc) 
    query += ' WHERE tripID = ' + str(tripID)
    #+ ', duration = ' + str(duration) + ', cost = ' + str(cost)
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute(query)
    # Commit the changes to the database
    db.get_db().commit()

    return jsonify({'message':  'Previous Trip information updated successfully for tripID ' + str(tripID)}), 200