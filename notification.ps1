function Show-Notification {
    param (
        [string]$message
    )

    Add-Type -AssemblyName System.Windows.Forms

    # Create a form
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Notification"
    $form.Size = New-Object System.Drawing.Size(300,100)
    $form.StartPosition = "CenterScreen"
    $form.TopMost = $true

    # Add a label to display the notification message
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,40)
    $label.Text = $Message
    $form.Controls.Add($label)


    # Show the form as a dialog
    $form.ShowDialog() | Out-Null
}
