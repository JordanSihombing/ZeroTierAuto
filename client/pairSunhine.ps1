# Execute textbox.exe and capture PIN value
$pin = & "textbox.exe"

# Extract only numbers using regular expressions
$pin = $pin -replace '[^\d]', ''

Write-Output "User input (PIN): $pin"

. .\notification.ps1
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
    Show-Notification -message "Error: No PIN value provided."
}
