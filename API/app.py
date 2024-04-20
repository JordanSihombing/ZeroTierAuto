from flask import Flask, request, jsonify
import json

app = Flask(__name__)

# Initialize an empty list to store the received ID numbers
received_pin = []
received_id = []

@app.route('/getid', methods=['GET'])
def handle_get_request():
    if len(received_id) > 0:
        last_pin = received_pin[-1]
        return jsonify({'id': last_pin}), 200
    else:
        return jsonify({'id': 'No available ID'}), 400
    
@app.route('/getpin', methods=['GET'])
def handle_get_request():
    if len(received_pin) > 0:
        last_pin = received_pin[-1]
        return jsonify({'id': last_pin}), 200
    else:
        return jsonify({'pin': 'No available PIN'}), 400

@app.route('/sendid', methods=['POST'])
def handle_post_request():
    pin = request.json.get('id')
    if pin is not None:
        received_pin.append(pin)
        return {'status': 'success'}, 200
    else:
        return {'status': 'error', 'message': 'ID number not provided'}, 400

@app.route('/sendpin', methods=['POST'])
def handle_post_request():
    pin = request.json.get('pin')
    if pin is not None:
        received_pin.append(pin)
        return {'status': 'success'}, 200
    else:
        return {'status': 'error', 'message': 'PIN not provided'}, 400

if __name__ == '__main__':
    app.run(debug=True)
