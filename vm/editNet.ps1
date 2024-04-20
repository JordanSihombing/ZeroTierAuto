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

# API Token
$API_TOKEN = "x3WCnpQ9DYjVGaeElv8C3XpKYS8M4O4y"

# API Endpoint URL
$API_URL = "https://my.zerotier.com/api/network/${network_id}"

# New request body JSON
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
        name = "Cloud Gaming Network"
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

# Send HTTP PATCH Request to update the network
Invoke-RestMethod -Method Patch -Uri $API_URL `
    -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $API_TOKEN"
    } `
    -Body $REQUEST_BODY

Write-Host "Network updated successfully."
