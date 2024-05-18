# Define the URL of the file to download
$url = "https://download.zerotier.com/dist/ZeroTier%20One.msi?_gl=1*383djw*_up*MQ..*_ga*MTEzOTEzMDU1MC4xNzE1MjQzNDI4*_ga_NX38HPVY1Z*MTcxNTI0MzQyNi4xLjAuMTcxNTI0MzQyNi4wLjAuMA..*_ga_6TEJNMZS6N*MTcxNTI0MzQyNi4xLjAuMTcxNTI0MzQyNi4wLjAuMA.."

# Define the path where you want to save the downloaded file
$outputPath = "$env:USERPROFILE\Downloads\ZeroTier One.msi"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $outputPath

# arguments for silent installation 
$arguments = "/S"

# Start the installation process
Start-Process -FilePath $outputPath -ArgumentList $arguments -Wait
