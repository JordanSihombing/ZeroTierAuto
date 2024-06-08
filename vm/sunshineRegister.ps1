# Define the static path to the Sunshine folder
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # If not running as administrator, restart the script as administrator
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Definition + "'"
    $newProcess.Verb = "runas"
    [System.Diagnostics.Process]::Start($newProcess) | Out-Null
    exit
}

$sunshineFolderPath = "C:\Program Files\Sunshine"

# Define the new folder and file paths
$configFolderPath = Join-Path -Path $sunshineFolderPath -ChildPath "config"
$configFilePath = Join-Path -Path $configFolderPath -ChildPath "sunshine_state.json"

# Check if the Sunshine folder exists
if (Test-Path -Path $sunshineFolderPath) {
    # Create the config folder if it doesn't exist
    if (-not (Test-Path -Path $configFolderPath)) {
        New-Item -Path $configFolderPath -ItemType Directory | Out-Null
    }

    # Define the JSON content
    $jsonContent = @"
{
    "username": "sunshine",
    "salt": "eRv)32cfYQoC7l=D",
    "password": "C72273B86456DBB8A797A2455FF78EEDD07EB83FAE8AD0A7E6506A6EDB133CC0"
}
"@

    # Create the JSON file and write the content to it
    Set-Content -Path $configFilePath -Value $jsonContent

    Write-Output "The config file has been created successfully at $configFilePath"

    # Reset the file permissions to the default inherited permissions
    # Get the parent directory's ACL
    $parentDirAcl = Get-Acl -Path $configFolderPath

    # Set the file's ACL to the parent directory's ACL (inherited permissions)
    Set-Acl -Path $configFilePath -AclObject $parentDirAcl

    Write-Output "The file permissions have been reset to the default inherited permissions."
} else {
    Write-Output "The folder at path '$sunshineFolderPath' was not found."
}

# Define the URL and the path to the session ID file--------------------------------------------
# $sessionIdFile = "session_id.txt"

# # Read the session ID from the file
# $sessionId = Get-Content -Path $sessionIdFile -Raw

# # Construct the full URL
# $url = "http://10.11.1.181:3000/v1/session/$sessionId/status"

# # Send the GET request
# $response = Invoke-RestMethod -Uri $url -Method Get

# # Extract the username from the response
# $username = $response.username

# # Output the username
# Write-Output "Username: $username"

# # Write the username to the sunshine_config.conf file
# $configOutputContent = "sunshine_name = $username"
# Set-Content -Path $configOutputFilePath -Value $configOutputContent

# Write-Output "The username has been written to $configOutputFilePath"

#Read-Host -Prompt "Press Enter to exit"