import os
import subprocess
from flask import Flask, request, jsonify, json
import requests

app = Flask(__name__)

# Initialize an empty list to store the received ID numbers
received_pin = []
received_id = []

USERNAME = 'sunshine'
PASSWORD = 'mysunshine'

def pairSunshine(pin):
    # Define API endpoint URL
    api_url = "https://localhost:47990/api/pin"

    # Define request body JSON
    request_body = json.dumps({'pin': pin}) 

    print(request_body)

    # Send HTTP POST request
    response = requests.post(api_url, data=request_body, auth=(USERNAME, PASSWORD), verify=False)

    # Write the response to pinlog.txt
    with open("pinlog.txt", "w") as file:
        file.write(response.json())
    return response

# Example usage
pin = '1234'
response = pairSunshine(pin)
print(response.status_code)  # Print status code to verify the request



@app.route('/getid', methods=['GET'])
def handle_get_id_request():
    if len(received_id) > 0:
        last_id = received_id[-1]
        return jsonify({'id': last_id}), 200
    else:
        return jsonify({'id': 'No available ID'}), 400
    
@app.route('/getpin', methods=['GET'])
def handle_get_pin_request():
    if len(received_pin) > 0:
        last_pin = received_pin[-1]
        return jsonify({'pin': last_pin}), 200
    else:
        return jsonify({'pin': 'No available PIN'}), 400

@app.route('/sendid', methods=['POST'])
def handle_post_id_request():
    id_number = request.json.get('id')
    if id_number is not None:
        received_id.append(id_number)
        return {'status': 'success'}, 200
    else:
        return {'status': 'error', 'message': 'ID number not provided'}, 400

@app.route('/sendpin', methods=['POST'])
def handle_post_pin_request():
    pin = request.json.get('pin')
    if pin is not None:
        try:
            response = pairSunshine(pin)
            if response.status_code == 200:
                if response.json().status == "true":
                    return {'status': 'success'}, 200
                else:
                    return {'status': 'error', 'message': 'PIN not valid'}, 400
            else:
                return {'status': 'error', 'message': 'failed'}, 400
        except Exception as e:
            return {'status': 'error', 'message': str(e)}, 500
    else:
        return {'status': 'error', 'message': 'PIN not provided'}, 400

@app.route('/nukethisvm', methods=['DELETE'])
def nuke_this_vm():
    try:
        # Get the directory where the current script is located
        current_dir = os.path.dirname(os.path.abspath(__file__))
        
        # Define the relative path to your PowerShell script
        relative_script_path = os.path.join('controller', 'vmEnd.ps1')
        
        # Construct the full path to the PowerShell script
        script_path = os.path.join(current_dir, relative_script_path)
        
        # Run the PowerShell script
        result = subprocess.run(['powershell', '-File', script_path], capture_output=True, text=True)

        if result.returncode != 0:
            return jsonify({'error': 'Failed to execute the script', 'details': result.stderr}), 500

        return jsonify({'message': 'Script executed successfully', 'output': result.stdout}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=2000)
