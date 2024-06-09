$SunshineCheck = "C:\Program Files\Sunshine\sunshine.exe"
$SunshinePath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Sunshine\sunshine.lnk"

if (-not (Test-Path $SunshineCheck)) {
    Write-Host "Sunshine is not installed."
    exit
}

Write-Host "Sunshine is installed."

#start Sunshine
$workDir =Split-Path -Path $SunshinePath -Parent
Write-Host "Setting working directory to $workDir"
Set-Location -Path $workDir

$shell =  New-Object -ComObject WScript.Shell

$Shortcut = $shell.CreateShortcut($SunshinePath)
$TargetPath = $Shortcut.$TargetPath

Start-Process -FilePath $TargetPath -NoNewWindow -Wait

Start-Sleep -Seconds 5

exit