# Ensure AudioDeviceCmdlets module is installed
if (-not (Get-Module -ListAvailable -Name AudioDeviceCmdlets)) {
  Install-Module -Name AudioDeviceCmdlets -Force
}

# Import the module
Import-Module AudioDeviceCmdlets

# List the audio devices with their Index and Name
$audioDevices = Get-AudioDevice -List | Select-Object Index, Name

# Display the list of audio devices
Write-Host "Available audio devices:"
$audioDevices | ForEach-Object { Write-Host "$($_.Index): $($_.Name)" }

# Prompt the user to select an audio device by Index
$selectedIndex = Read-Host "Enter the Index of the audio device you want to set as default"

# Validate the input
if ($selectedIndex -match '^\d+$') {
  $selectedIndex = [int]$selectedIndex
  if ($audioDevices.Index -contains $selectedIndex) {
      # Set the selected audio device as the default
      Set-AudioDevice -Index $selectedIndex
      Write-Host "Audio device set to $($audioDevices | Where-Object { $_.Index -eq $selectedIndex }).Name"
  } else {
      Write-Host "Invalid Index. Please run the script again and select a valid Index."
  }
} else {
  Write-Host "Invalid input. Please enter a numeric index."
}