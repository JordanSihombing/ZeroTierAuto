# API Token
$API_TOKEN = "x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
$API_URL = "https://api.zerotier.com/api/v1/network"

# Request Body JSON
$REQUEST_BODY = '{}'

# Send HTTP POST Request to create a new network
$response = Invoke-RestMethod -Method Post `
    -Uri $API_URL `
    -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $API_TOKEN"
    } `
    -Body $REQUEST_BODY

# Extract the ID from the response
$network_id = $response.id

$outputFile = "network_id.txt"
$network_id > $outputFile
#----------------------------------------------------------------------
# Get VM IP address
$IP_VM = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).Name).IPAddress

# param (
#     [string]$session_id
# )

# $session_id = $IP_VM

#----------------------------------------------------------------------
$TARGET = "http://10.11.1.169:3000/v1/session/${session_id}/connection/start"

# Construct ID_BODY with network_id
$BODY = @{
    webhook = @{
        host = $IP_VM
        port = "2000"
    }
    network_id = $network_id
} | ConvertTo-Json

# Send HTTP POST Request to start connection
$response = Invoke-RestMethod -Method Post `
    -Uri $TARGET `
    -ContentType "application/json" `
    -Body $BODY

# Check if the response is successful (status code 200)
if ($response.StatusCode -eq 200) {
    Write-Host "Connection started successfully."
} else {
    Write-Host "Error: Failed to start connection. Status code: $($response.StatusCode)"
}
