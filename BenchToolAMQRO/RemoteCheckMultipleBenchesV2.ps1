# Copyright (C) Continental AG
# All Rights Reserved
# --------------------------------------------------
# Preconditions
# Run the next powershell command as admin in remote benches
# Enable-PSRemoting -Force
# Share a folder in remote bench with Path: C:\Tools\BenchTool
# Define the list of computers and credentials
# --------------------------------------------------
$executionTime = Measure-Command { # For measuring execution time

# To bypass the use of bench access with only IP, also it needs to be executed in RemotePC as Admin
winrm quickconfig | Out-Null
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force | Out-Null

#-------------------------------------------------- Variables ---------------------------------------------------------
$timeout = 5 # Define the timeout value (in seconds)
$jobs = @()  # Start empty array for required jobs
#-------------------------------------------------- Function calls ----------------------------------------------------
. (Join-Path -Path $PSScriptRoot -ChildPath 'Functions.ps1')

#-------------------------------------------------- Start Main code ---------------------------------------------------
$localUser=$env:USERNAME

# Call the function BenchListFromTxt to get info
$dataBenches = BenchListFromTxt
# Loop through each computer
foreach ($computer in $dataBenches) {
  $UsernameCred = $computer.Username
  $PasswordCred = ConvertTo-SecureString $computer.Password -AsPlainText -Force
  $Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $UsernameCred, $PasswordCred

  # # Find the index where ComputerName matches to be used in case of error
  # $index = GetIndexComputerName -ComputerName $computer.ComputerName -computers $dataBenches
  # Run the script on the remote machines asynchronously (as a job)
  $job = Invoke-Command -ComputerName $computer.ComputerName -Credential $Cred -ScriptBlock {
    
    # Define required functions in the remote session using -ArgumentList $callFunctions
    param ($funcString)
    Invoke-Expression $funcString
    
    # Set local variables in remote computer
    $currentComputer=$using:computer.ComputerName
    $currentLocalUser=$using:localUser
    # TODO: Send a command to change name in gitconfig
    # git config --global user.name $currentLocalUser
    $dataBenches=$using:dataBenches
    # $currentIndex=$using:index
    # Call GetIndexComputerName to find the index where ComputerName matches, even to be used in case of error
    $index = GetIndexComputerName -ComputerName $currentComputer -computers $dataBenches

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
      Write-Host "$($dataBenches[$index].Alias) : $($dataBenches[$index].ComputerName) : $ipAddressString : Not Initialized : $($dataBenches[$index].Username) : $($dataBenches[$index].Password)"
    }
    else {
      Write-Host "$($dataBenches[$index].Alias) : $($dataBenches[$index].ComputerName) : $ipAddressString : $($userIdState[1]) : $($userIdState[0]) : $($dataBenches[$index].Password)"
    }
    
  } -ArgumentList $callFunctions -AsJob
  # Add the job to the jobs array
  $jobs += $job
}
$index = 0
# Monitor the jobs and handle the timeout for each
foreach ($job in $jobs) {
  # Wait for each job with a specified timeout
  if (Wait-Job -Job $job -Timeout $timeout) {
    # If the job completes within the timeout
    # Write-Host "Job $($job.Id) on computer $($job.Location) completed."
    # Retrieve the output of the completed job
    $jobOutput = Receive-Job -Id $job.Id
    Write-Host $jobOutput
  }
  else {
    # If the job did not complete within the timeout
    # Write-Host "Job $($job.Id) on computer $($job.Location) timed out. Terminating the job..."
    # Stop the unresponsive job
    Stop-Job -Job $job
    Remove-Job -Job $job
    # Write-Host "Job $($job.Id) has been terminated."
    
    # Offline means When is disconnected from network or power off
    Write-Host "$($dataBenches[$index].Alias) : $($dataBenches[$index].ComputerName) : No IP : Offline : $($dataBenches[$index].Username) : $($dataBenches[$index].Password)"
    # Write-Host "No Alias : No Name : No IP : Offline : No User : No Pass"
  }
  $index++
}
# TODO: Check the effect
Exit-PSSession   

# For measuring execution time
} # Display the result in seconds
$executionTime.TotalSeconds

