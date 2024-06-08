if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # If not running as administrator, restart the script as administrator
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Definition + "'"
    $newProcess.Verb = "runas"
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null
    exit
}


Set-Location -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

try {
    & ..\vm\disconnectVM.ps1
    Write-Host "Successfully disconnected"
}
catch {
    Write-Host "Error disconnecting VM:" $_.Exception.Message
}

try {
    & ..\vm\deleteNet.ps1
    Write-Host "Network successfully destroyed"
}
catch {
    Write-Host "Error destroying network:" $_.Exception.Message
}

Write-Host "Destroying network..."

# Read session_id from session_id.txt
$session_id = Get-Content -Path "session_id.txt"

# Check if session_id is not empty
if ($session_id -ne "") {
    $URL = "http://10.11.1.181:6969/v1/vms/$session_id"

    try {
        Invoke-RestMethod -Method Delete -Uri $URL -ContentType "application/json"
        Write-Host "Sending Delete VM"
        LogProcess -Type "log" -Message "VM successfully destroyed"
    }
    catch {
        Write-Host "Error destroying VM via API:" $_.Exception.Message
        LogProcess -Type "log" -Message "Error destroying VM via API: $_.Exception.Message"
    }
} else {
    Write-Host "Error: No session_id value provided in session_id.txt."
    LogProcess -Type "log" -Message "Error: No session_id value provided in session_id.txt."
}

DisplaySwitch 3