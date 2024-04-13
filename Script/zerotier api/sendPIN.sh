#!/bin/bash

# Execute textbox.py and capture its output (PIN value)
user_input=$(python textbox.py)

# Check if user_input is not empty
if [ -n "$user_input" ]; then
    # Set the URL
    URL="https://localhost:47990/api/pin"

    # Send API POST request with pin value
    curl -X POST -H "Content-Type: application/json" -d "{\"pin\": \"$user_input\"}" "$URL"
else
    echo "Error: No PIN value provided."
fi
