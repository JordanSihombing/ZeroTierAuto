# Function to check if Cloudflare WARP is installed
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

# Function to connect Cloudflare WARP using CLI
function Connect-Warp {
    $warpCliPath = Test-WarpInstalled
    if ($warpCliPath) {
        Start-Process -FilePath $warpCliPath -ArgumentList "disconnect" -Wait
    } else {
        Write-Host "Error: Cloudflare WARP CLI not found."
    }
}

# Main script
$warpCliPath = Test-WarpInstalled
if ($warpCliPath) {
    Write-Host "Cloudflare WARP is already installed at '$warpCliPath'."
    Connect-Warp
} else {
    Write-Host "Cloudflare WARP is not installed. Downloading and installing..."
    Invoke-WarpDownload
    Install-Warp
    Write-Host "Cloudflare WARP installed successfully."
    Connect-Warp
}
