# PowerShell equivalent of the provided batch script

# Check for admin privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Restarting script with admin privileges
    Start-Process powershell -Verb RunAs -ArgumentList ("-File", "$($MyInvocation.MyCommand.Path)")
    exit
}

# Initiating ZeroTier connection
Write-Host "Initiating ZeroTier connection..."

# Check for ZeroTier Desktop UI executable
$ZerotierExe = ""
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

if ($ZerotierExe -eq "") {
    Write-Host "ZeroTier Desktop UI not found."
    exit
}

# Initiating ZeroTier and connecting to the network
$network_id = $args[0]
if (-not $network_id) {
    Write-Host "No network ID specified."
    exit
}

# Starting ZeroTier Desktop UI
Start-Process -FilePath $ZerotierExe

# Waiting for ZeroTier to start
Start-Sleep -Seconds 3

# Joining the network
zerotier-cli join $network_id
Start-Sleep -Seconds 3
zerotier-cli status

Write-Host "ZeroTier connection established!"

# Closing ZeroTier Desktop UI
Get-Process -Name zerotier_desktop_ui | Stop-Process -Force

exit