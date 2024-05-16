import tkinter as tk
import requests
import json
import sys

global session_id


def sendPIN (pin):
    if pin:
        print(session_id)
        # Set the URL
        URL = f"http://10.147.20.105:3000/v1/session/{session_id}/pair"

        # Create JSON body with PIN value
        body = {
            "pin": pin
        }

        # Send API POST request with PIN value
        response = requests.post(URL, json=body)

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
        # Create the main window
        root = tk.Tk()
        root.title("PIN")

        # Create a label
        label = tk.Label(root, text="Enter your PIN:")
        label.pack()

        # Create an entry widget (textbox) with a wider width
        entry = tk.Entry(root, width=40)  # Set the width to 50 characters
        entry.pack()

        # Create a button to submit the input
        submit_button = tk.Button(root, text="Submit", command=get_input)
        submit_button.pack()

        # Run the main event loop
        root.mainloop()
    else:
        exit("No session ID provided")




