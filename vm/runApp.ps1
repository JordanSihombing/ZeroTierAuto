# Define the path to your Python executable
$python_exe = "python"

# Define the path to your Flask application file
$flask_app = "app.py"

# Build the command to run the Flask app
$command = "$python_exe $flask_app"

# Execute the command
Invoke-Expression $command
