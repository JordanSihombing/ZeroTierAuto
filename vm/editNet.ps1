# Read the network_id from network_id.txt
$outputFile = "network_id.txt"
$network_id = Get-Content $outputFile

# Check if the file was read successfully (optional)
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

# Check if the session ID was read successfully (optional)
if (-not $session_id) {
  Write-Error "Error: Could not read session ID from session_id.txt"
}

# API Token
$API_TOKEN = "x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
$API_URL = "https://my.zerotier.com/api/network/${network_id}"

# New request body JSON with name from session_id.txt
$REQUEST_BODY = @{
    config = @{
        capabilities = @{}
        dns = @{
            domain = "google.com"
            servers = @("10.0.0.3")
        }
        enableBroadcast = $true
        ipAssignmentPools = @(
            @{
                ipRangeStart = "10.0.0.1"
                ipRangeEnd = "10.0.0.255"
            }
        )
        mtu = 2800
        multicastLimit = 32
        name = $session_id  # Assigning session_id as name
        private = $false
        routes = @(
            @{
                target = "10.0.0.0/24"
                via = $null
            }
        )
        rules = @{}
        ssoConfig = @{
            enabled = $true
            mode = "default"
            clientId = "some-client-id"
            allowList = @("string")
        }
        tags = @{}
        v4AssignMode = @{zt = $true}
        v6AssignMode = @{
            "6plane" = $true
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
} | ConvertTo-Json

# Send HTTP Post Request to update the network
Invoke-RestMethod -Method Post -Uri $API_URL `
    -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $API_TOKEN"
    } `
    -Body $REQUEST_BODY

Write-Host "Network updated successfully."
