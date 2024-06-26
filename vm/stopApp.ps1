# Define the name of the Flask application
$processName = "python"

# Get the PID of the Python process running your Flask application
$flaskProcess = Get-Process | Where-Object {$_.Name -eq $processName} | Select-Object -First 1

if ($flaskProcess) {
    # Terminate the Python process running your Flask application
    Stop-Process -Id $flaskProcess.Id
    Write-Host "Flask application stopped successfully."
} else {
    Write-Host "No Flask application running."
}
