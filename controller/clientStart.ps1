param (
    [string]$network_id,
    [string]$session_id
)

$retryCount = 3  # Number of times to retry each script

function RunScript {
    param(
        [string]$scriptPath
    )

    $retry = 0
    while ($retry -lt $retryCount) {
        $retry++
        Write-Host "Attempting to run $scriptPath. Retry: $retry"

        # Execute the script
        &$scriptPath

        if ($? -eq $true) {
            Write-Host "$scriptPath executed successfully."
            return $true  # Exit the function if script executed successfully
        } else {
            Write-Host "Error: $scriptPath failed to execute."
            Start-Sleep -Seconds 5  # Wait before retrying
        }
    }

    Write-Host "Error: Maximum retries reached for $scriptPath."
    return $false  # Return false if maximum retries reached
}

# Check network
if (-not (RunScript ".\warp\counterEduroam.ps1")) {
    exit  # Exit script if maximum retries reached 
}

# Connect client to network
if (-not (RunScript ".\client\connectClient.ps1 -network_id $network_id")) {
    exit  
}

# Run Moonlight
if (-not (RunScript ".\client\runMoonlight.ps1")) {
    exit  
}

# Pair Sunshine
if (-not (RunScript ".\client\pairSunshine.ps1 -session_id $session_id")) {
    exit  
}
