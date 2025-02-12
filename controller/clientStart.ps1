param (
    [string]$network_id,
    [string]$session_id,
    [string]$token
)

$direc=$PSScriptRoot
Set-Location $direc\..\

.\controller\warp\warpConnect.ps1

.\client\connectClient.ps1 -network_id $network_id

.\client\runMoonlight.ps1

.\dist\textbox.exe $session_id $token
