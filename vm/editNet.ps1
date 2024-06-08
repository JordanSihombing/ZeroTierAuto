if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # If not running as administrator, restart the script as administrator
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Definition + "'"
    $newProcess.Verb = "runas"
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null
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

# Read the session ID from session_id.txt
$session_id_file = "session_id.txt"
$session_id = Get-Content $session_id_file

# Check if the session ID was read successfully
if (-not $session_id) {
  Write-Error "Error: Could not read session ID from session_id.txt"
}

# API Token
$API_TOKEN = "x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
$API_URL = "https://my.zerotier.com/api/network/$network_id"

# New request body JSON with name from session_id.txt/
$REQUEST_BODY = @{
    config = @{
        enableBroadcast = $true
        ipAssignmentPools = @(
            @{
                ipRangeStart = "192.168.10.5"
                ipRangeEnd = "192.168.10.254"
            }
        )
        mtu = 2800
        multicastLimit = 32
        name = $session_id  # Assigning session_id as name
        private = $false
        routes = @(
            @{
                target = "192.168.10.0/24"
                via = $null
            }
        )
        
        v4AssignMode = @{zt = $true}
        v6AssignMode = @{
            "6plane" = $false
            rfc4193 = $false
            zt = $false
        }
    }

    description = "Cloud Gaming network"
    rulesSource = "accept;"
    permissions = @{
        "00000000-0000-0000-0000-000000000000" = @{
            a = $true
            d = $true
            m = $true
            r = $true
        }
    }
    ownerId = "00000000-0000-0000-0000-000000000000"
    capabilitiesByName = @{}
    tagsByName = @{}
    } | ConvertTo-Json -Depth 5

# Send HTTP Post Request to update the network
Invoke-RestMethod -Method Post -Uri $API_URL `
    -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $API_TOKEN"
    } `
    -Body $REQUEST_BODY

Write-Host $REQUEST_BODY

Write-Host "Network updated successfully."
