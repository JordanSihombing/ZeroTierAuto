param (
        [string] $network_id
)

# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
{
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
}
else
{
   # We are not running "as Administrator" - so relaunch as administrator

   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

   # Specify the current script path and name as a parameter with arguments
   $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "' -network_id " + $network_id;

   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";

   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);

   # Exit from the current, unelevated, process
   exit
}

## Initiating ZeroTier connection
Write-Output "Initiating ZeroTier connection..." 

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
    & "clientRequirement\downloadZeroTier.ps1"
}

# Initiating ZeroTier and connecting to the network


# Starting ZeroTier Desktop UI
Start-Process -FilePath $ZerotierExe

# Waiting for ZeroTier to start
Start-Sleep -Seconds 3

Write-Host $network_id

# Joining the network
zerotier-cli join $network_id
Start-Sleep -Seconds 3
zerotier-cli status

# Closing ZeroTier Desktop UI
# Get-Process -Name zerotier_desktop_ui | Stop-Process -Force