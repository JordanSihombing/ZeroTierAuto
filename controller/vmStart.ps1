& "API\dist\app.exe" #start API

# Stop the ZeroTier service
Stop-Service -Name ZeroTierService

# Define the path to ZeroTier's working directory
$zerotierDir = "C:\ProgramData\ZeroTier\One"

# Delete the files identity.public and identity.secret
Remove-Item -Path "$zerotierDir\identity.public" -Force
Remove-Item -Path "$zerotierDir\identity.secret" -Force

# Start the ZeroTier service
Start-Service -Name ZeroTierService

.\vm\createNew.ps1 #Create new network
.\warp\counterEduroam.ps1 #Check if network is restricted 
Start-Sleep -Seconds 5
.\vm\editNet.ps1 #Set network to public
Start-Sleep -Seconds 5
.\vm\connectVM.ps1  #Connect to network
Start-Sleep -Seconds 5
.\vm\runSunshine.ps1 #Run sunshine 

