param (
    [string]$session_id
)

.\vm\disconnectVM.ps1
.\vm\deleteNet.ps1 -session_id $session_id