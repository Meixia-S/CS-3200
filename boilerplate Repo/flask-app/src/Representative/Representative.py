from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Representative = Blueprint('Representative', __name__)

# Get all the products from the database
@Representative.route('/Representative', methods=['GET'])
def get_representatives_information():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    query = 'SELECT * FROM Representative ORDER BY rating DESC'
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

@Representative.route('/Representative', methods=['POST'])
def add_new_representative():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    employeeID = the_data['employeeID']
    firstName = the_data['firstName']
    lastName = the_data['lastName']
    rating = the_data['rating']

    # Constructing the query
    query = 'INSERT INTO Representative (employeeID, firstName, lastName, rating) values ("'
    query += str(employeeID) + '", "'
    query += firstName + '", "'
    query += lastName + '", '
    query += str(rating) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


@Representative.route('/Representative/<employeeID>', methods=['PUT'])
def update_representative_information(employeeID):
    # Parse the JSON data from the request
    data = request.get_json()

    # Check if the required fields are present in the request data
    if 'firstName' not in data or  'lastName' not in data or 'rating' not in data:
        return jsonify({'error': 'Missing required fields'}), 400

    # Extract data from the request
    firstName = data['firstName']
    lastName = data['lastName']
    rating = data['rating']

    current_app.logger.info(data)

    # use cursor to update the representative information in the database
    query = 'UPDATE Representative SET firstName = %s, lastName = %s, rating = %s  WHERE employeeID = %s'

    # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute(query, (firstName, lastName, rating, employeeID))
    # Commit the changes to the database
    db.get_db().commit()

    return jsonify({'message': 'Representative information updated successfully'}), 200