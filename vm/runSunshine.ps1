# Check for Sunshine installation
$SunshineExe = ""
$SunshineExePaths = @(
    "${env:ProgramFiles}\Sunshine\sunshine.exe",
    "${env:ProgramFiles(x86)}\Sunshine\sunshine.exe"
)

foreach ($path in $SunshineExePaths) {
    if (Test-Path $path) {
        $SunshineExe = $path
        break
    }
}

if (-not $SunshineExe) {
    Write-Host "Sunshine is not installed."
    exit
}

Write-Host "Sunshine is installed."

param (
    [string]$pin
)

# Start Sunshine
Start-Process -FilePath $SunshineExe

# Wait for Sunshine to start
Start-Sleep -Seconds 5

# Open URL in default browser
$url = "https://localhost:47990"
Start-Process $url

# Define API endpoint URL
$apiUrl = "https://localhost:47990/api/pin"

# Define request body JSON
$requestBody = @{
    pin = $pin
} | ConvertTo-Json

# Send HTTP POST request
$response = Invoke-RestMethod -Uri $apiUrl -Method Post -ContentType "application/json" -Body $requestBody

# Output response
Write-Host "Response: $response"

exit
