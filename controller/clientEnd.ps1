param (
    [string]$network_id
)



.\client\disconnectClient.ps1 -network_id $network_id
.\warp\warpDisconnect.ps1

#Show-Notification -Message "Connection terminated successfully!"
