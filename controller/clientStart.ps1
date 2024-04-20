param (
    [string]$network_id,
    [string]$session_id
)

.\warp\counterEduroam.ps1 #Check network
.\client\connectClient.ps1 -network_id $network_id
.\client\runMoonlight.ps1 
.\client\pairSunhine.ps1 -session_id $session_id