.\vm\runApp.ps1 #start API
.\vm\createNew.ps1 #Create new network
.\warp\counterEduroam.ps1 #Check if network is restricted 
Start-Sleep -Seconds 5
.\vm\editNet.ps1 #Set network to public
Start-Sleep -Seconds 5
.\vm\connectVM.ps1  #Connect to network
Start-Sleep -Seconds 5
.\vm\runSunshine.ps1 #Run sunshine 

