# Path to the Sunshine shortcut
$SunshinePath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Sunshine\Sunshine.lnk"

# Check if the Sunshine shortcut exists
if (Test-Path -Path $SunshinePath) {
    # Run the Sunshine shortcut
    Invoke-Item -Path $SunshinePath
} else {
    # Output a message indicating the shortcut was not found
    Write-Output "The Sunshine shortcut was not found at $SunshinePath"
}
