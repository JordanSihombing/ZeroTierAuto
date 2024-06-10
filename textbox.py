import tkinter as tk
import requests
import json
import sys
import subprocess

global session_id
global token

def ping(host):
    try:
        output = subprocess.check_output(["ping", "-c", "1", host])
        return True
    except subprocess.CalledProcessError:
        return False

def sendPIN(pin):
    if pin:
        print(session_id)
        # Ping destinations and set URL
        if ping("10.11.1.181"):
            URL = f"http://10.11.1.181:3000/v1/session/{session_id}/pair"
        elif ping("10.147.20.105"):
            URL = f"http://10.147.20.105:3000/v1/session/{session_id}/pair"
        else:
            print("Error: No destination is reachable.")
            return

        # Create JSON body with PIN value
        body = {
            "pin": pin
        }

        headers = {
            'Authorization': f'Bearer {token}',
            'Content-Type': 'application/json'
        }

        # Send API POST request with PIN value
        response = requests.post(URL, data=json.dumps(body), headers=headers)

        with open("pinlog.txt", "w") as file:
            file.write(response.text)

        # Print the response for debugging (optional)
        print(response.status_code)
        print(response.json())
        
    else:
        print("Error: No PIN value provided.")
    

def get_input():
    user_input = entry.get()
    sendPIN(user_input)
    

if __name__ == "__main__":
    if len(sys.argv) > 1:
        session_id = sys.argv[1]
        token = sys.argv[2]
        # Create the main window
        root = tk.Tk()
        root.title("PIN")

        # Create a label
        label = tk.Label(root, text="Enter your PIN:")
        label.pack()

        # Create an entry widget (textbox) with a wider width
        entry = tk.Entry(root, width=40)  # Set the width to 40 characters
        entry.pack()

        # Create a button to submit the input
        submit_button = tk.Button(root, text="Submit", command=get_input)
        submit_button.pack()

        # Run the main event loop
        root.mainloop()
    else:
        exit("No session ID provided")
