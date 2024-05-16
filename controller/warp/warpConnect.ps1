# Function to check if Cloudflare WARP is installed
function LogProcess {
    param(
			[string]$Type,
			[string]$Message
    )
    if ($script:isFirstCall) {
			try {
				Write-Output $message | Out-File -Append -FilePath "C:\setup\app\ZeroTierAuto.log" -ErrorAction Stop
			} catch {
				if ($_.Exception.Message -match "Could not find a part of the path") {
					# Create the file and retry logging
					New-Item -Path "C:\setup\app\ZeroTierAuto.log" -ItemType File -Force | Out-Null
					$message | Out-File -Append -FilePath "C:\setup\app\ZeroTierAuto.log" -ErrorAction Stop
				} else {
						Throw "Unexpected error occurred while logging: Type: $Type, Message: $Message, Error:"
				}
			}
			$script:isFirstCall = $false
    }
    try {
			if ($Type -eq "log") {
				$Message | Out-File -Append -FilePath "C:\setup\app\ZeroTierAuto.log" -ErrorAction Stop
				Write-Host $Message
			} elseif ($Type -eq "run") {
				Invoke-Expression $Message | Out-File -Append -FilePath "C:\setup\app\ZeroTierAuto.log" -ErrorAction Stop
			} 
    } catch {
			Write-Output "Error occurred while logging: Type: $Type, Message: $Message, Error: $_"
			# You might want to log this error as well
	}
}



function Test-WarpInstalled {
    $warpExe = ""
    $warpExePaths = @(
        "${env:ProgramFiles}\Cloudflare\Cloudflare WARP\warp-cli.exe",
        "${env:ProgramFiles(x86)}\Cloudflare\Cloudflare WARP\warp-cli.exe"
    )

    foreach ($path in $warpExePaths) {
        if (Test-Path $path) {
            $warpExe = $path
            break
        }
    }

    return $warpExe
}

# Function to download Cloudflare WARP for windows
function Invoke-WarpDownload {
    $url = "https://1111-releases.cloudflareclient.com/windows/Cloudflare_WARP_Release-x64.msi"
    $outputFile = "Cloudflare_WARP_Release-x64.msi"
    Invoke-WebRequest -Uri $url -OutFile $outputFile
}

# Function to install Cloudflare WARP
function Install-Warp {
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/i Cloudflare_WARP_Release-x64.msi /quiet" -Wait
}

# # Function to register Cloudflare WARP using CLI
# function Register-Warp {
#     $warpCliPath = Test-WarpInstalled
#     if ($warpCliPath) {
#         Start-Process -FilePath $warpCliPath -ArgumentList "register" -Wait
#         LogProcess -Type "log" -Message "Cloudflare WARP CLI register success!"
#     } else {
#         LogProcess -Type "log" -Message "Error: Cloudflare WARP CLI cannot register"
#     }
# }

# # Function to connect Cloudflare WARP using CLI
# function Connect-Warp {
#     $warpCliPath = Test-WarpInstalled
#     if ($warpCliPath) {
#         Start-Process -FilePath $warpCliPath -ArgumentList "connect" -Wait
#         LogProcess -Type "log" -Message "Cloudflare WARP CLI connect success!"
#     } else {
#         LogProcess -Type "log" -Message "Error: Cloudflare WARP CLI cannot connect"
#     }
# }

# Main script
$warpCliPath = Test-WarpInstalled
if ($warpCliPath) {
    Write-Host "Cloudflare WARP is already installed at '$warpCliPath'."
    warp-cli registration delete
    warp-cli registration new
    warp-cli connect
} else {
    Write-Host "Cloudflare WARP is not installed. Downloading and installing..."
    Invoke-WarpDownload
    Install-Warp
    Write-Host "Cloudflare WARP installed successfully."
    warp-cli register
    warp-cli connect
}
