# Copyright (C) Continental AG
# All Rights Reserved
# --------------------------------------------------
# Preconditions
# Requires powershell 7 or higher
# Run the next powershell command as admin in remote benches
# Enable-PSRemoting -Force
# Share a folder in remote bench with Path: C:\Tools\BenchTool
# Define the list of computers and credentials
# --------------------------------------------------

$executionTime = Measure-Command { # For measuring execution time
# To bypass the use of bench access with only IP, also it needs to be executed in RemotePC as Admin
# winrm quickconfig | Out-Null
# Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force | Out-Null

#-------------------------------------------------- Variables ---------------------------------------------------------
$timeout = 5 # Define the timeout value (in seconds)
$jobs = @()  # Start empty array for required jobs
$localUser=$env:USERNAME
$LogicalProcessors = (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors
#-------------------------------------------------- Function calls ----------------------------------------------------
. (Join-Path -Path $PSScriptRoot -ChildPath 'Functions.ps1')

#-------------------------------------------------- Start Main code ---------------------------------------------------
# Call the function BenchListFromTxt to get info
$dataBenches = BenchListFromTxt
# Loop through each computer
foreach ($computer in $dataBenches) {
  # Start a ThreadJob for each computer
  $jobs += Start-ThreadJob -ScriptBlock {
    # Set all required parameters
    param ($computer, $Cred, $funcString, $localUser, $dataBenches, $callFunctions)
    # Prepare credentials
    $UsernameCred = $computer.Username
    $PasswordCred = ConvertTo-SecureString $computer.Password -AsPlainText -Force
    $Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UsernameCred, $PasswordCred
    
    Invoke-Command -ComputerName $computer.ComputerName -Credential $Cred -ScriptBlock {
      # Define required functions in the remote session using -ArgumentList $callFunctions
      param ($funcString, $computer, $localUser, $dataBenches)
      Invoke-Expression $funcString
      
      # Set local variables in remote computer
      $currentComputer = $computer.ComputerName
      $currentLocalUser = $localUser
      # TODO: Send a command to change name in gitconfig
      # git config --global user.name $currentLocalUser
      $dataBenches = $dataBenches
      # Perform additional operations here
      # Call GetIndexComputerName to find the index where ComputerName matches, even to be used in case of error
      $index = GetIndexComputerName -ComputerName $currentComputer -computers $dataBenches
      # Write-Host doesn't work so we use return
      # return "Running on $currentComputer with user $currentLocalUser index $index"

      # Run the quser command and capture the output
      # 2>&1 redirects the error stream (stream 2) to the output stream (stream 1).
      # This ensures that any errors that occur while running quser (such as if no users are logged in)
      # are captured in the $quserOutput variable alongside the normal output.
      $quserOutput = quser 2>&1
      # Call getUserIdState to get job user and state of remote session
      $userIdState = getUserIdState -quserOutput $quserOutput

      # Get current computer IP, these are two options depending the format of the output.
      # $ipAddress = [System.Net.Dns]::GetHostAddresses($ComputerName) | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -First 1
      # $ipAddressString = $ipAddress.IPAddressToString
      $ipAddress = [System.Net.Dns]::GetHostAddresses($ComputerName) | Where-Object { $_.AddressFamily -eq 'InterNetwork' }
      $ipAddressString = $ipAddress[0].IPAddressToString
      # $ipAddressString = getIpAddress -computerName $dataBenches[$index].ComputerName
      
      # Check if quser command is valid or not
      if ($quserOutput -like "*No User exists for*") {
        # Print bench info with state Not Initialized, it means it's possible to sign in
        # Write-Host "$Alias : $ComputerName : $ipAddressString : Not Initialized : $userId : $Passsword"
        return "$($dataBenches[$index].Alias) : $($dataBenches[$index].ComputerName) : $ipAddressString : Not Initialized : $($dataBenches[$index].Username) : $($dataBenches[$index].Password)"
      }
      else {
        return "$($dataBenches[$index].Alias) : $($dataBenches[$index].ComputerName) : $ipAddressString : $($userIdState[1]) : $($userIdState[0]) : $($dataBenches[$index].Password)"
      }
      # Arguments used within Invoke-Command
    } -ArgumentList $funcString, $computer, $localUser, $dataBenches
    # Arguments used within Start-ThreadJob -ScriptBlock
  } -ArgumentList $computer, $Cred, $callFunctions, $localUser, $dataBenches -ThrottleLimit $LogicalProcessors
}

# Initialize an empty array to hold the outputs
$outputArray = @()
# Retrieve and display the output from each job
Wait-Job -Job $jobs
foreach ($job in $jobs) {
  $jobOutput = Receive-Job -Job $job
  # Write-Host $jobOutput
  # Convert the output to a string and append to the output array
  $outputArray += $jobOutput # | Out-String
}
# Combine all parts into one string
$outputString = $outputArray -join "`n" # we can add "`n" to separete one newline more

# Output the final string
Write-Host $outputString -ForegroundColor Cyan
# Write-Host $outputString -ForegroundColor Cyan
# Clean up jobs after retrieving output
$jobs | ForEach-Object { Remove-Job -Job $_ }

} # Display the result in seconds
$executionTime.TotalSeconds


# Initialize an array to hold values
$aliases = @()
$computerNames = @()
$ipAddresses = @()
$computerNames = @()
$userStates = @()
$userIds = @()
$passwords = @()
# Split the string into lines
$lines = $outputString -split "`n"
# Loop through each line and separate the values into variables
$structuredData = foreach ($line in $lines) {
  $fields = $line -split ':'
  [pscustomobject]@{
    Alias        = $fields[0]
    ComputerName = $fields[1]
    ipAddress    = $fields[2]
    userState    = $fields[3]
    Username     = $fields[4]
    Password     = $fields[5]
  }
}
$structuredData.Count
$structuredData
Write-Host $structuredData[7].Alias -ForegroundColor Red
Write-Host $structuredData.ComputerName -ForegroundColor Red

# # Load the Windows Forms assembly
# Add-Type -AssemblyName System.Windows.Forms
# Add-Type -AssemblyName System.Drawing

# # Create a new form
# $form = New-Object System.Windows.Forms.Form
# $form.Text = "Alias List"
# $form.Width = 500
# $form.Height = 300

# # Set the initial vertical position for the labels
# $yPosition = 20

# # Loop through each object in the structured data and create a label for each property
# foreach ($entry in $structuredData) {
#     # Create a label for Alias
#     $benchInfo = New-Object System.Windows.Forms.Label
#     $benchInfo.Text = "$($entry.Alias) : $($entry.ComputerName) : $($entry.ipAddress)"
#     $benchInfo.Width = 235
#     $benchInfo.Location = New-Object System.Drawing.Point(20, $yPosition)
#     $benchInfo.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
#     $form.Controls.Add($benchInfo)
    
#     # Create a label for userState
#     $labelUserState = New-Object System.Windows.Forms.Label
#     $labelUserState.Text = "$($entry.userState)"
#     $labelUserState.Width = 100
#     $labelUserState.Location = New-Object System.Drawing.Point(270, $yPosition)
#     $labelUserState.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#     $form.Controls.Add($labelUserState)

#     # Adjust the vertical position for the next set of labels
#     $yPosition += 30
# }

# # Show the form
# $form.ShowDialog()