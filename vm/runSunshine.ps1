# Hardcoded path to Sunshine executable
$SunshineCheck = "C:\Program Files\Sunshine\sunshine.exe"
$SunshineExe = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Sunshine\sunshine.exe"

if (-not (Test-Path $SunshineCheck)) {
    Write-Host "Sunshine is not installed."
    exit
}

Write-Host "Sunshine is installed."

# Start Sunshine
$workingDirectory = Split-Path -Path $SunshineExe -Parent
Write-Host "Setting working directory to $workingDirectory"
Set-Location -Path $workingDirectory
Write-Host "Starting Sunshine..."
Start-Process -FilePath $SunshineExe -NoNewWindow -Wait

# Wait for Sunshine to start
Start-Sleep -Seconds 5

exit
