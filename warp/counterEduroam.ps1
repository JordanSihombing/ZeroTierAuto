# Function to get the connected network name
function Get-NetworkName {
    $networkName = (Get-NetConnectionProfile).Name
    return $networkName
}

# Main script
$restrictedNetworks = @('eduroam', 'PLaiGROUND','STEI Pikiraneun 4', 'HotspotITB', 'Hotspot ITB')  
$connectedNetworkName = Get-NetworkName

# Check if the connected network name is in the list of restricted networks
if ($restrictedNetworks -contains $connectedNetworkName) {
    Write-Host "Connected to '$connectedNetworkName' network. Running Cloudflare WARP script..."
    .\warp.ps1  # Run the warp.ps1 script
} else {
    Write-Host "Connected to '$connectedNetworkName' network. Not running Cloudflare WARP script."
}
