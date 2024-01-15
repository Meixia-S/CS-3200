from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Discount = Blueprint('Discount', __name__)

# Get all the products from the database
@Discount.route('/Discount/<discountID>', methods=['GET'])
def get_discounts(discountID):
        # get a cursor object from the database
    cursor = db.get_db().cursor()

    query = 'SELECT *\n'
    query += ' FROM Discount\n'
    query += ' WHERE discountID = ' + str(discountID)

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

    return jsonify(json_data)


@Discount.route('/Discount', methods=['POST'])
def add_new_discount():
    
    # collecting data from the request object 
    data = request.json
    current_app.logger.info(data)

    #extracting the variable
    discountID = data['discountID']
    paymentID = data['paymentID']
    type = data['type']
    endDate = data['endDate']
    startDate = data['startDate']
    percentageOff = data['percentageOff']

    # Constructing the query
    query = 'INSERT INTO Discount (discountID, paymentID, type, endDate, startDate, percentageOff) values ("'
    query += str(discountID) + '", "'
    query += str(paymentID) + '", "'
    query += type + '", "'
    query += str(endDate) + '", "'
    query += str(startDate) + '", '
    query += str(percentageOff) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@Discount.route('/Discount/<paymentID>', methods=['DELETE'])
def delete_discount(paymentID):
    query = 'DELETE FROM Visit_Memo WHERE memoID = ' + str(paymentID)
    current_app.logger.info(query)

    # executing and committing the DELETE statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    if cursor.rowcount == 0:
        return 'No Discount found with given ID', 404
    return 'Discount has been deleted successfully', 200