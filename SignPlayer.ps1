Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(800, 600)  # Adjust size as needed
$form.FormBorderStyle = "None"
$form.TopMost = $true

$image = [System.Drawing.Image]::FromFile("C:\Scripts\splash.png")  # Update the path to your image
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Image = $image
$pictureBox.Dock = "Fill"
$pictureBox.SizeMode = "Zoom"

$form.Controls.Add($pictureBox)

$form.Show()
Start-Sleep -Seconds 5
$form.Close()

Start-Process -FilePath "firefox" -ArgumentList "--kiosk https://yourwebsite.com"  # Replace with your website
