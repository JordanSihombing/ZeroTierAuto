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

    # Set the URL
    $URL = "http://10.11.1.169:3000/v1/session/$session_id/pair"

    # Create JSON body with PIN value
    $body = @{
        pin = $pin
    } | ConvertTo-Json

    # Send API POST request with PIN value
    Invoke-RestMethod -Method Post -Uri $URL -ContentType "application/json" -Body $body
} else {
    Write-Host "Error: No PIN value provided."
}
