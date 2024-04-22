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

# Start Sunshine
Start-Process -FilePath $SunshineExe

# Wait for Sunshine to start
Start-Sleep -Seconds 5

# Open URL in default browser
$url = "https://localhost:47990"
Start-Process $url

# Define the URL of the Flask API endpoint
$apiUrl = 'http://127.0.0.1:2020/getpin'

# Make a GET request to the API endpoint
$response = Invoke-RestMethod -Uri $apiUrl -Method Get

# Extract the PIN from the response
$pin = $response.pin

# Output the extracted PIN
Write-Host "PIN: $pin"

# Check if PIN is provided
if (-not $pin) {
    Write-Host "No PIN specified."
    exit 1
}

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
