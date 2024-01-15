from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Customer_Flight = Blueprint('Customer_Flight', __name__)

@Customer_Flight.route('/Customer_Flight', methods=['POST'])
def add_customer_to_flight():
    
    # collecting data from the request object 
    data = request.json
    current_app.logger.info(data)

    #extracting the variable
    customerID = data['customerID']
    fightID = data['flightID']

    # Constructing the query
    query = 'INSERT INTO Customer_Flight (customerID, flightID) values ("'
    query += str(customerID) + '",'
    query += str(fightID) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@Customer_Flight.route('/Customer_Flight/<customerID>', methods=['PUT'])
def update_customer_flight_information(customerID):
    # Parse the JSON data from the request
    data = request.get_json()

    # Check if the required fields are present in the request data
    if 'flightID' not in data: return jsonify({'error': 'Missing required fields'}), 400

    # Extract data from the request
    flightID = data['flightID']

    current_app.logger.info(data)

    
    # use cursor to update the representative information in the database
    query = 'UPDATE Customer_Flight SET flightID = %s WHERE customerID = %s'
    
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute(query, (flightID, customerID))
    # Commit the changes to the database
    db.get_db().commit()

    return jsonify({'message': 'Customer successfully added to flight ' + str(flightID)}), 200


@Customer_Flight.route('/Customer_Flight/<customerID>', methods=['DELETE'])
def delete_flight_from_customer(customerID):
    query = 'DELETE FROM Customer_Flight WHERE customerID = ' + str(customerID)
    current_app.logger.info(query)
    # executing and committing the DELETE statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    if cursor.rowcount == 0:
        return 'No customer found with given ID', 404
    return 'Customer deleted from Flight successfully', 200