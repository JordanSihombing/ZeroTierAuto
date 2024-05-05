# PowerShell equivalent of the provided batch script

# Check for admin privileges
# if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
#     # Restarting script with admin privileges
#     Start-Process powershell -Verb RunAs -ArgumentList ("-File", "$($MyInvocation.MyCommand.Path)")
#     exit
# }

# Terminating ZeroTier connection
Write-Host "Terminating ZeroTier connection..."

# Check for ZeroTier Desktop UI executable
$ZerotierExePaths = @(
    "${env:ProgramFiles}\ZeroTier\One\zerotier_desktop_ui.exe",
    "${env:ProgramFiles(x86)}\ZeroTier\One\zerotier_desktop_ui.exe"
)

foreach ($path in $ZerotierExePaths) {
    if (Test-Path $path) {
        $ZerotierExe = $path
        break
    }
}

if (-not $ZerotierExe) {
    Write-Host "ZeroTier Desktop UI not found."
    exit
}

# Read the network_id from network_id.txt
$outputFile = "network_id.txt"
$network_id = Get-Content $outputFile

# Check if the file was read successfully 
if ($network_id) {
  zerotier-cli join $network_id
  Start-Sleep -Seconds 2
  zerotier-cli status
} else {
  Write-Error "Error: Could not read network ID from network_id.txt"
}


# Initiating ZeroTier and disconnecting from the network
Start-Process -FilePath $ZerotierExe
Start-Sleep -Seconds 5
zerotier-cli leave $network_id
Start-Sleep -Seconds 3
zerotier-cli status
Write-Host "ZeroTier connection terminated!"

# Closing ZeroTier Desktop UI
Get-Process -Name zerotier_desktop_ui | Stop-Process -Force

exit
