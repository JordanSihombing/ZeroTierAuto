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

exit
