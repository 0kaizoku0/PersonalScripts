# Run PowerShell as Administrator

# Set the new computer name
$NewComputerName = "NewComputerName"

# Set the new workgroup name
$NewWorkgroup = "NewWorkgroup"

# Rename the computer and set the new workgroup
Rename-Computer -NewName $NewComputerName -Workgroup $NewWorkgroup -Force -Restart
