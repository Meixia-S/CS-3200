from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

Visit_Memo = Blueprint('Visit_Memo', __name__)

# Get all the products from the database
@Visit_Memo.route('/Visit_Memo/<employeeID>', methods=['GET'])
def get_visit_memos(employeeID):

    # get a cursor object from the database
    cursor = db.get_db().cursor()

    query = 'SELECT *\n'
    query += ' FROM Visit_Memo vm JOIN Representative ON Representative.employeeID = vm.employeeID\n'
    query += ' WHERE vm.employeeID = ' + str(employeeID)

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


@Visit_Memo.route('/Visit_Memo', methods=['POST'])
def add_new_visit_memo():
    
    # collecting data from the request object 
    data = request.json
    current_app.logger.info(data)

    #extracting the variable
    memoID = data['memoID']
    employeeID = data['employeeID']
    duration = data['duration']
    notes = data['notes']
    date = data['date']

    # Constructing the query
    query = 'INSERT INTO Visit_Memo (memoID, employeeID, duration, notes, date) values ("'
    query += str(memoID) + '", "'
    query += str(employeeID) + '", "'
    query += str(duration) + '", "'
    query += notes + '", '
    query += str(date) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


@Visit_Memo.route('/Visit_Memo/<memoID>', methods=['PUT'])
def update_visit_memo_notes(memoID):
    # Parse the JSON data from the request
    data = request.get_json()

    # Check if the required fields are present in the request data
    if 'notes' not in data: return jsonify({'error': 'Missing required fields'}), 400

    # Extract data from the request
    notes = data['notes']

    current_app.logger.info(data)
    # use cursor to update the representative information in the database
    query = 'UPDATE Visit_Memo SET notes = %s Where memoID = %s'
   
     # get a cursor object from the database
    cursor = db.get_db().cursor()
    cursor.execute(query,(notes, memoID))
    # Commit the changes to the database
    db.get_db().commit()

    return jsonify({'message': 'Visit Memo information updated successfully'}), 200


@Visit_Memo.route('/Visit_Memo/<memoID>', methods=['DELETE'])
def delete_visit_memo(memoID):
    query = 'DELETE FROM Visit_Memo WHERE memoID = ' + str(memoID)
    current_app.logger.info(query)

    # executing and committing the DELETE statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    if cursor.rowcount == 0:
        return 'No Visit Memo found with given ID', 404
    return 'Visit Memo deleted successfully', 200