$SunshineCheck = "C:\Program Files\Sunshine\sunshine.exe"
$SunshinePath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Sunshine\sunshine.lnk"

# Check if Sunshine is installed
if (-not (Test-Path $SunshineCheck)) {
    Write-Host "Sunshine is not installed."
    exit
}

Write-Host "Sunshine is installed."

# Set working directory to the directory containing the Sunshine shortcut
$workDir = Split-Path -Path $SunshinePath -Parent
Write-Host "Setting working directory to $workDir"
Set-Location -Path $workDir

# Create WScript.Shell COM object
$shell = New-Object -ComObject WScript.Shell

# Create shortcut object
$Shortcut = $shell.CreateShortcut($SunshinePath)
$TargetPath = $Shortcut.TargetPath

# Start Sunshine
Write-Host "Starting Sunshine from $TargetPath"
Start-Process -FilePath $TargetPath -NoNewWindow -Wait

Start-Sleep -Seconds 5

Write-Host "Sunshine started successfully."
exit
