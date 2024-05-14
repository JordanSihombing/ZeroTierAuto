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

Write-Host $response

Write-Host "Net ID:" $network_id

$netFile = "network_id.txt"
$network_id > $netFile
#----------------------------------------------------------------------
# Get VM IP address
$IP_VM = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).Name).IPAddress

$apiUrl = "http://10.11.1.181:6969/v1/checkSID/$($IP_VM)"

# Send API request
$response = Invoke-RestMethod -Method Get -Uri $apiUrl

# Extract SID from response
$session_id = $response.details.SID

$sesFile = "session_id.txt"
$session_id > $sesFile

# Set new computer name
$NewComputerName = $session_id

# Update registry values
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" -Name "ComputerName" -Value $NewComputerName
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "Hostname" -Value $NewComputerName

# Refresh environment to reflect the change without restart
$env:COMPUTERNAME = $NewComputerName

#----------------------------------------------------------------------
$TARGET = "http://10.11.1.181:3000/v1/session/${session_id}/connection/start"


# $networkInterfaces = Get-NetIPAddress | Where-Object { $_.InterfaceAlias -like "*ZeroTier One*" -and $_.AddressFamily -eq "IPv4" }

# # Loop through each interface and display the IPv4 address
# foreach ($interface in $networkInterfaces) {
#     Write-Output "Interface Alias: $($interface.InterfaceAlias)"
#     Write-Output "IPv4 Address: $($interface.IPAddress)"
# }

# Construct ID_BODY with network_id
$BODY = @{
    webhook = @{
        host = $IP_VM
        port = "2000"
    }
    network_id = $network_id
} | ConvertTo-Json

Write-Host $session_id
# Send HTTP POST Request to start connection
$response = Invoke-RestMethod -Method Post `
    -Uri $TARGET `
    -ContentType "application/json" `
    -Body $BODY

Write-Host $response
# Check if the response is successful (status code 200)
if ($response.status -eq "success") {
    Write-Host "Connection started successfully."
} else {
    Write-Host "Error: Failed to start connection. Status code: $($response.StatusCode)"
}
