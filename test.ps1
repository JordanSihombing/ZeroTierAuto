# Define the URL of the Flask API endpoint
$apiUrl = 'http://127.0.0.1:2020/getpin'

# Make a GET request to the API endpoint
$response = Invoke-RestMethod -Uri $apiUrl -Method Get

# Extract the PIN from the response
$pin = $response.pin

# Output the extracted PIN
Write-Host "PIN: $pin"
