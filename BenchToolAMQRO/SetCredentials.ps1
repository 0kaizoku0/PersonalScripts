# Script to start a powershell remote in the computer selected from benchlist
#-------------------------------------------------- Function calls ----------------------------------------------------
. (Join-Path -Path $PSScriptRoot -ChildPath 'Functions.ps1')

# Call the function BenchList to get the structure with the benches
$computers = BenchListFromTxt
$BenchName = $computers[1].ComputerName
$Username = $computers[1].Username
$Password = ConvertTo-SecureString $computers[1].Password -AsPlainText -Force
# Use the credentials
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $Password

$Cred

# Copy the script to the remote computer
# Define the local file path and the remote destination (UNC path)
# $localFilePath = "RemoteCheck.ps1"
# $remoteDestination = "\\$BenchName\BenchTool"

# # Copy the file to the remote destination
# Copy-Item -Path $localFilePath -Destination $remoteDestination -Force

# Enter the session and run the script
Enter-PSSession -ComputerName $BenchName -Credential $Cred

# Define the path to your script
$scriptPath = "C:\Tools\BenchTool\RemoteCheck.ps1"

# Run the script on the remote machine
Invoke-Command -ComputerName $BenchName -Credential $Cred -ScriptBlock {
  # & $using:scriptPath
  Write-Host "Hi $($computer.ComputerName)"
}