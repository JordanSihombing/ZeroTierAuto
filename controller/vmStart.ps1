if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # If not running as administrator, restart the script as administrator
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Definition + "'"
    $newProcess.Verb = "runas"
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null
    exit
}

# Get all processes related to "sunshine"
$processes = Get-Process | Where-Object { $_.ProcessName -like "*sunshine*" }

# Stop each process
foreach ($process in $processes) {
    Write-Host "Stopping process: $($process.ProcessName) with ID $($process.Id)..."
    Stop-Process -Id $process.Id -Force
}

Write-Host "All processes related to 'sunshine' have been stopped."


ipconfig /renew *Eth*

Set-Location C:\setup\scripts\ZeroTierAuto

Start-Process -FilePath "API\dist\app.exe" #start API

# Stop the ZeroTier service
Stop-Service -Name ZeroTierOneService

# Define the path to ZeroTier's working directory
$zerotierDir = "C:\ProgramData\ZeroTier\One"

# Delete the files identity.public and identity.secret
Remove-Item -Path "$zerotierDir\identity.public" -Force
Remove-Item -Path "$zerotierDir\identity.secret" -Force

# Start the ZeroTier service
Start-Service -Name ZeroTierOneService

.\vm\createNew.ps1 #Create new network
.\controller\warp\warpConnect.ps1
Start-Sleep -Seconds 1
.\vm\editNet.ps1 #Set network to public
Start-Sleep -Seconds 1
.\vm\connectVM.ps1  #Connect to network
Start-Sleep -Seconds 1
.\vm\sunshineRegister.ps1
Start-Sleep -Seconds 3
.\vm\runSunshine.ps1 #Run sunshine 
