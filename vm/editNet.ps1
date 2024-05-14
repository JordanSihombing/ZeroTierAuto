# Read the network_id from network_id.txt
$outputFile = "network_id.txt"
$network_id = Get-Content $outputFile

# Check if the file was read successfully
if ($network_id) {
  zerotier-cli join $network_id
  Start-Sleep -Seconds 2
  zerotier-cli status
} else {
  Write-Error "Error: Could not read network ID from network_id.txt"
}

# Read the session ID from session_id.txt
$session_id_file = "session_id.txt"
$session_id = Get-Content $session_id_file

# Check if the session ID was read successfully
if (-not $session_id) {
  Write-Error "Error: Could not read session ID from session_id.txt"
}

# API Token
$API_TOKEN = "x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
$API_URL = "https://my.zerotier.com/api/network/$network_id"

# New request body JSON with name from session_id.txt/
$REQUEST_BODY = @{
    config = @{
        private = $false
        name = $session_id
    }
    description = "Cloud Gaming network"
    } | ConvertTo-Json -Depth 10

# Send HTTP Post Request to update the network
Invoke-RestMethod -Method Post -Uri $API_URL `
    -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $API_TOKEN"
    } `
    -Body $REQUEST_BODY

Write-Host $REQUEST_BODY

Write-Host "Network updated successfully."
