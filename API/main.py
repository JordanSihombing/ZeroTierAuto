from flask import Flask, request, jsonify
import json

app = Flask(__name__)

# Initialize an empty list to store the received ID numbers
received_id = []

@app.route('/getid', methods=['GET'])
def handle_get_request():
    if len(received_id) > 0:
        last_id = received_id[-1]
        return jsonify({'id': last_id}), 200
    else:
        return jsonify({'id': 'No available ID'}), 400

@app.route('/sendid', methods=['POST'])
def handle_post_request():
    id_number = request.json.get('id')
    if id_number is not None:
        received_id.append(id_number)
        return {'status': 'success'}, 200
    else:
        return {'status': 'error', 'message': 'ID number not provided'}, 400

if __name__ == '__main__':
    app.run(debug=True)
