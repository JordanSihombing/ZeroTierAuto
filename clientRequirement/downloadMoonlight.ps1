# Define the URL of the file to download
$url = "https://github.com/moonlight-stream/moonlight-qt/releases/download/v5.0.1/MoonlightSetup-5.0.1.exe"

# Define the path where you want to save the downloaded file
$outputPath = "$env:USERPROFILE\Downloads\MoonlightSetup-5.0.1.exe"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $outputPath

# arguments for silent installation 
$arguments = "/S"

# Start the installation process
Start-Process -FilePath $outputPath -ArgumentList $arguments -Wait
