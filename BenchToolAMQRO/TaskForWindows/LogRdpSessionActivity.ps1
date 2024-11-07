# Script to log the date and time when a user starts or ends a remote session
# To use is it's necessary import the task LogRdpSessionActivity.xml and create the LogRdpSessionActivity.exe file.
# Add the LogRdpSessionActivity.exe to the path C:\Tools\BenchTool in the remote bench

#-------------------------------------------------- Function Definitions ----------------------------------------------
#-------------------------------------------------- getUserIdState ----------------------------------------------------
function getUserIdState {
  param (
    [Parameter(Mandatory)]
    $quserOutput  # input value from $quserOutput = quser 2>&1
  )
    
  foreach ($line in $quserOutput) {
    # Skip the header line
    if ($line -match "^ USERNAME") { continue }

    # Split the line by spaces (consider multiple spaces)
    $columns = $line -split "\s+"
    # Write-Host "Column Length $($columns.Length)" -ForegroundColor Green # Use it to know real value if you don't get the Active or Disc State
    # Disc=8 Active=9 For LogRdpSession
    # Handle different cases: with or without a session name
    if ($columns.Length -le 8) {
      # Case without SESSIONNAME
      # uif54465                                  2  Disc            .  16/10/2024 03:00 p. m.
      $userId = $columns[1]
      $state = $columns[2]  # STATE is in the third column
    }
    elseif ($columns.Length -ge 9) {
      # Case with SESSIONNAME
      # uif54465              rdp-tcp#0           2  Active          .  16/10/2024 03:00 p. m.
      $userId = $columns[1]
      $state = $columns[3]  # STATE is still in the fourth column
    }
  }
  if ($state -eq "Active") {
    $state = "In Use"
  }
  elseif ($state -eq "Disc") {
    $state = "Available"
  }
  else {
    $state = "Unknown"
  }
  return @($userId, $state)
}
#-------------------------------------------------- getUserIdState ----------------------------------------------------

#-------------------------------------------------- Create csv --------------------------------------------------------
# Define the path to the CSV file where activity will be logged
$csvPath = Join-Path $PSScriptRoot "output.csv"

# Remove-Item $csvPath -Force
$headers = [PSCustomObject]@{
  UserName  = " "
  initState = ""
  initDate  = ""
  initTime  = ""
  endState  = ""
  endDate   = ""
  endTime   = ""
}
if (-not (Test-Path $csvPath)) {
  # Export the headers to a new CSV file
  $headers | Export-Csv -Path $csvPath -NoTypeInformation
}
#-------------------------------------------------- Create csv --------------------------------------------------------
#-------------------------------------------------- Fill first cycle --------------------------------------------------
# TODO:


# Initialize variables
# $currentState = "Unknown"  # Initial state
# Main loop to monitor the RDP session activity
while ($true) {
  # Get the current session states
  $quserOutput = quser 2>&1
  # Write-Host "$quserOutput"
  $userIdStates = getUserIdState -quserOutput $quserOutput
  $username = $userIdStates[0]
  $currentState = $userIdStates[1]
  # Monitoring current state and user
  Write-Host "User: $username State: $currentState" -ForegroundColor Green
  # Check if the current state is different from the previous state
  #TODO: Check -ne "Available" to consider any change to available
  if (($currentState -eq "Available" -and $previousState -eq "In Use") -or ($currentState -eq "Available" -and ($previousState -eq "" -or $previousState -eq "Not Initialized"))) {
    # Update the previous state to the current state
    Write-Host "State changed from In Use to Available" -ForegroundColor Yellow
    # Update columns for disconnection
    # "UserName,initState,initDate,initTime,endState,endDate,endTime"
    $data = Import-Csv -Path $csvPath
    $rowCount = $data.Count - 1
    Write-Host "Rows $rowCount" -ForegroundColor Cyan
    $data[$rowCount].endState = "Disconected"
    $data[$rowCount].endDate = (Get-Date).ToString("yyyy-MM-dd")
    $data[$rowCount].endTime = (Get-Date).ToString("HH:mm:ss")
    $data | Export-Csv -Path $csvPath -NoTypeInformation
    
  } 
  elseif ($currentState -eq "In Use" -and $previousState -eq "Available") {
    # Update the previous state to the current state
    Write-Host "State changed from Available to In Use" -ForegroundColor Red
    # Update columns for disconnection
    # "UserName,initState,initDate,initTime,endState,endDate,endTime"
    # Define data to add
    # Start-Sleep -Seconds 10 # Time window to update user before read
    $lastUser = Get-Content -Path "LastUser.txt"
    $lastUser
    $newRow = [PSCustomObject]@{
      UserName  = $lastUser
      initState = "Active"
      initDate  = (Get-Date).ToString("yyyy-MM-dd")
      initTime  = (Get-Date).ToString("HH:mm:ss")
      endState  = ""
      endDate   = ""
      endTime   = ""
    }
    # Append the new row to the CSV file
    $newRow | Export-Csv -Path $csvPath -Append -NoTypeInformation
  }
  else {
    # Write-Host "No state change; current state is still $currentState"
    if ($currentState -eq "Available") {
      $countAvailable++
      # Delete Last User if is available for more than x seconds
      if ($countAvailable -ge 10) {
        # Remove-Item -Path "LastUser.txt" -Force -ErrorAction SilentlyContinue
        Set-Content -Path "LastUser.txt" -Value "Unknown" -NoNewline
        Write-Host "Last User Deleted" -ForegroundColor Blue
        $countAvailable = 0
      }
    }
    else {
      $countAvailable = 0
    }
  }
  # Save previous state for next cycle
  $previousState = $currentState
  # Pause for 10 seconds before checking again
  Start-Sleep -Seconds 1
  # Export to CSV file
}
# -WindowStyle Hidden -File "C:\Tools\BenchTool\LogRdpSessionActivity.ps1"