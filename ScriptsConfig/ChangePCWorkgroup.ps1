# Run PowerShell as Administrator

# Set the new computer name
$NewComputerName = "NewComputerName"

# Set the new workgroup name
$NewWorkgroup = "NewWorkgroup"

# Rename the computer
Rename-Computer -NewName $NewComputerName -Force -Restart

# Set the new workgroup using netdom command
$NetdomArguments = "/reboot:10 /d:$NewWorkgroup"
Start-Process -FilePath "netdom" -ArgumentList $NetdomArguments -Wait
