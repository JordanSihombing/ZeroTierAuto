$VM_IP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).Name).IPAddress

# API endpoint
$apiUrl = "http://10.147.20.105/v1/checkSID?ip=$($VM_IP):6969"

# Send API request
$response = Invoke-RestMethod -Method Get -Uri $apiUrl

# Extract SID from response
$session_id = $response.details.SID

# Target URL
$TARGET = "http://10.11.1.169:3000/v1/session/${session_id}/connection/start"

# Send HTTP GET Request to retrieve the last ID
$response = Invoke-RestMethod -Method Get -Uri $TARGET

# Extract the ID from the response
$network_id = $response.network_id

# API Token
$API_TOKEN = "pHeu4iyxaLTivxSm8oB7hI1hSaPK7zX2"

# API Endpoint URL
$API_URL = "https://my.zerotier.com/api/network/${network_id}"

# Send HTTP DELETE Request
Invoke-RestMethod -Method Delete -Uri $API_URL -Headers @{
    "Authorization" = "Bearer $API_TOKEN"
}
