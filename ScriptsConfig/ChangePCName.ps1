# Run PowerShell as Administrator

# Set the new computer name
$NewComputerName = "C300"

# Rename the computer
Rename-Computer -NewName $NewComputerName -Force -Restart
