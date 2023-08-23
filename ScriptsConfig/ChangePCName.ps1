# Run PowerShell as Administrator

# Set the new computer name
$NewComputerName = "NewComputerName"

# Rename the computer
Rename-Computer -NewName $NewComputerName -Force -Restart
