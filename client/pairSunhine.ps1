# Execute textbox.exe and capture PIN value
param (
    [string]$session_id
)

$direc=$PSScriptRoot
Set-Location $direc\..\

Start-Process -FilePath "textbox.exe" -Wait

$pin =Get-Content pinSun.txt


Write-Output "User input (PIN): $pin"

# Check if extracted PIN is not empty
if ($pin -ne "") {

    # Set the URL
    $URL = "http://10.147.20.105:3000/v1/session/$session_id/pair"

    # Create JSON body with PIN value
    $body = @{
        pin = $pin
    } | ConvertTo-Json

    # Send API POST request with PIN value
    Invoke-RestMethod -Method Post -Uri $URL -ContentType "application/json" -Body $body
} else {

}
