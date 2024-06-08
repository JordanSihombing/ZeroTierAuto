# Set up the log file
$logFile = "logging.txt"
Start-Transcript -Path $logFile

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # If not running as administrator, restart the script as administrator
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Definition + "'"
    $newProcess.Verb = "runas"
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null
    exit
}

# API Token
$API_TOKEN = "x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
$API_URL = "https://api.zerotier.com/api/v1/network"

# Request Body JSON
$REQUEST_BODY = '{}'

# Log and Send HTTP POST Request to create a new network
Write-Host "Sending HTTP POST Request to create a new network..."
$response = Invoke-RestMethod -Method Post `
    -Uri $API_URL `
    -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $API_TOKEN"
    } `
    -Body $REQUEST_BODY

# Extract the ID from the response
Write-Host "new network success"
$network_id = $response.id

Write-Host "Response received:"
Write-Host $response

Write-Host "Net ID:" $network_id

$netFile = "network_id.txt"
$network_id > $netFile

#----------------------------------------------------------------------
# Get VM IP address+
$EthernetAdapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.Name -eq "Ethernet" }
$IP_VM = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias $EthernetAdapter.Name).IPAddress

Write-Host "VM IP Address:" $IP_VM

$apiUrl = "http://10.11.1.181:6969/v1/checkSID/$($IP_VM)"

# Log and Send API request
Write-Host "Sending API request to check SID..."
$response = Invoke-RestMethod -Method Get -Uri $apiUrl

# Extract SID from response
$session_id = $response.details.SID

Write-Host "Response received:"
Write-Host $response

$sesFile = "session_id.txt"
$session_id > $sesFile

# Set new computer name
$NewComputerName = $session_id

Write-Host "Setting new computer name to $NewComputerName..."

# Update registry values
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" -Name "ComputerName" -Value $NewComputerName
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "Hostname" -Value $NewComputerName

# Refresh environment to reflect the change without restart
$env:COMPUTERNAME = $NewComputerName

#----------------------------------------------------------------------
$TARGET = "http://10.11.1.181:3000/v1/session/${session_id}/connection/start"

# Construct ID_BODY with network_id
$BODY = @{
    webhook = @{
        host = $IP_VM
        port = "2000"
    }
    network_id = $network_id
} | ConvertTo-Json

Write-Host "Session ID:" $session_id
Write-Host "Sending HTTP POST Request to start connection..."

# Log and Send HTTP POST Request to start connection
$response = Invoke-RestMethod -Method Post `
    -Uri $TARGET `
    -ContentType "application/json" `
    -Body $BODY

Write-Host "Response received:"
Write-Host $response

# Check if the response is successful (status code 200)
if ($response.status -eq "success") {
    Write-Host "Connection started successfully."
} else {
    Write-Host "Error: Failed to start connection. Status code: $($response.StatusCode)"
}

# End the transcript
Stop-Transcript
