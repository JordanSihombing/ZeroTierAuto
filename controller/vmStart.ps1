param (
    [string]$pin
)

.\vm\createNew.ps1 #Create new network
.\warp\counterEduroam.ps1 #Check if network is restricted 
.\vm\editNet.ps1 #Set network to public
.\vm\connectVM.ps1  #Connect to network
.\vm\runSunshine.ps1 -pin $pin #Run sunshine : using passing parameter -pin 

