# Define the static path to the Sunshine folder
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
} else {
    Write-Output "The folder at path '$sunshineFolderPath' was not found."
}