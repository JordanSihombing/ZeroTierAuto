.\vm\disconnectVM.ps1
.\vm\deleteNet.ps1

$session_id = Get-Content -Path "session_id.txt"

# Read session_id from session_id.txt
$session_id = Get-Content -Path "session_id.txt"

# Check if session_id is not empty
if ($session_id -ne "") {
    # Set the URL using the session_id from the file
    $URL = "http://10.11.1.181:6969/v1/vms/$session_id"

    # Send API DELETE request without a body
    Invoke-RestMethod -Method Delete -Uri $URL -ContentType "application/json"
    LogProcess -Type "log" -Message "Network successfully destroyed"
} else {
    LogProcess -Type "log" -Message "Error: No session_id value provided in session_id.txt."
}
