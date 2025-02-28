Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName Microsoft.VisualBasic

# Function to show the EULA in a scrollable window
function Show-EULA {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "TuxCare EULA Agreement"
    $form.Size = New-Object System.Drawing.Size(600, 400)
    $form.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Please read the EULA before proceeding:"
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $label.Size = New-Object System.Drawing.Size(560, 20)
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Multiline = $true
    $textBox.ScrollBars = "Vertical"
    $textBox.ReadOnly = $true
    $textBox.Text = "TuxCare EULA: https://tuxcare.com/legal/`n`nBy using this script, you agree to the following terms:`n
    1. This software is provided 'AS IS' without any warranties.
    2. You must ensure compliance with your organization's licensing.
    3. Misuse of this script is not the responsibility of TuxCare.`n`nPress 'Agree' to continue."
    $textBox.Location = New-Object System.Drawing.Point(10, 40)
    $textBox.Size = New-Object System.Drawing.Size(560, 270)
    $form.Controls.Add($textBox)

    $agreeButton = New-Object System.Windows.Forms.Button
    $agreeButton.Text = "Agree"
    $agreeButton.Location = New-Object System.Drawing.Point(350, 320)
    $agreeButton.Size = New-Object System.Drawing.Size(100, 30)
    $agreeButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Controls.Add($agreeButton)

    $declineButton = New-Object System.Windows.Forms.Button
    $declineButton.Text = "Decline"
    $declineButton.Location = New-Object System.Drawing.Point(460, 320)
    $declineButton.Size = New-Object System.Drawing.Size(100, 30)
    $declineButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.Controls.Add($declineButton)

    $form.AcceptButton = $agreeButton
    $form.CancelButton = $declineButton

    $result = $form.ShowDialog()
    return $result -eq [System.Windows.Forms.DialogResult]::OK
}

# Function to get License Key from the user
function Get-LicenseKey {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Enter License Key"
    $form.Size = New-Object System.Drawing.Size(400, 200)
    $form.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Enter your license key:"
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $label.Size = New-Object System.Drawing.Size(360, 20)
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10, 40)
    $textBox.Size = New-Object System.Drawing.Size(360, 25)
    $form.Controls.Add($textBox)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "Submit"
    $okButton.Location = New-Object System.Drawing.Point(140, 80)
    $okButton.Size = New-Object System.Drawing.Size(100, 30)
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Controls.Add($okButton)

    $form.AcceptButton = $okButton

    if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $textBox.Text
    } else {
        return $null
    }
}

# Function to display the tokenized URL in a copyable text box
function Show-TokenizedURL($tokenizedURL) {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Registration Successful"
    $form.Size = New-Object System.Drawing.Size(500, 200)
    $form.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Your registration was successful. Copy the URL below:"
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $label.Size = New-Object System.Drawing.Size(460, 20)
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Multiline = $false
    $textBox.ReadOnly = $true
    $textBox.Text = $tokenizedURL
    $textBox.Location = New-Object System.Drawing.Point(10, 40)
    $textBox.Size = New-Object System.Drawing.Size(460, 25)
    $form.Controls.Add($textBox)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "Close"
    $okButton.Location = New-Object System.Drawing.Point(200, 80)
    $okButton.Size = New-Object System.Drawing.Size(100, 30)
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Controls.Add($okButton)

    $form.AcceptButton = $okButton

    $form.ShowDialog()
}

### MAIN SCRIPT EXECUTION ###
if (-not (Show-EULA)) {
    exit
}

$LICENSE = Get-LicenseKey
if ([string]::IsNullOrEmpty($LICENSE)) {
    [System.Windows.Forms.MessageBox]::Show("License key is required!", "Error")
    exit
}

$CLN_REGISTER_SERVER = "https://cln.cloudlinux.com/cln/api/els/server/register"
$HOSTNAME = $env:COMPUTERNAME

# Make API request
$body = @{ key = $LICENSE; host_name = $HOSTNAME } | ConvertTo-Json -Compress
$response = Invoke-RestMethod -Uri $CLN_REGISTER_SERVER -Method Post -Headers @{ "Content-Type" = "application/json" } -Body $body

# Extract token
$TOKEN = $response.token
if (-not $TOKEN) {
    [System.Windows.Forms.MessageBox]::Show("Error: Token not received.", "Error")
    exit
}

# Generate the correct tokenized repository URL
$TOKENIZED_URL = "https://windows.tuxcare.com/dotnet/$TOKEN/6.0/"

# Display final result in a copyable text box
Show-TokenizedURL $TOKENIZED_URL
