# Execute textbox.py and capture PIN value
$pin = python textbox.py

# Extract only numbers using regular expressions
$pin = $pin -replace '[^\d]', ''

Write-Output "User input (PIN): $pin"

param (
    [string]$session_id
)

# Check if extracted PIN is not empty
if ($pin -ne "") {
    # Set the session ID (replace {session_id} with the actual session ID)
    $session_id = "your_session_id_here"

    # Set the URL
    $URL = "http://34.101.181.190:3000/v1/session/$session_id/pair"

    # Create JSON body with PIN value
    $body = @{
        pin = $pin
    } | ConvertTo-Json

    # Send API POST request with PIN value
    Invoke-RestMethod -Method Post -Uri $URL -ContentType "application/json" -Body $body
} else {
    Write-Host "Error: No PIN value provided."
}
