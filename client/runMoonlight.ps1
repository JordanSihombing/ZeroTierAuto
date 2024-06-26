# Check for Moonlight installation
$MoonlightExe = ""
$MoonlightExePaths = @(
    "${env:ProgramFiles}\Moonlight Game Streaming\Moonlight.exe",
    "${env:ProgramFiles(x86)}\Moonlight Game Streaming\Moonlight.exe"
)

foreach ($path in $MoonlightExePaths) {
    if (Test-Path $path) {
        $MoonlightExe = $path
        break
    }
}

if ($MoonlightExe -eq "") {
    .\clientRequirement\downloadMoonlight.ps1
}

Write-Host "Moonlight is installed."

# Start Moonlight
Start-Process -FilePath $MoonlightExe

exit
