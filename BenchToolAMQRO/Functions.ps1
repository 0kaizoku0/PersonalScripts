#-------------------------------------------------- Function Definitions ----------------------------------------------

#-------------------------------------------------- BenchList ---------------------------------------------------------
function BenchList {
  $benchListpath = @("
Alias0,ComputerName0,user0,pass0
Alias1,ComputerName1,user1,pass1
Alias2,ComputerName2,user2,pass2
Alias3,ComputerName3,user3,pass3
Alias4,ComputerName4,user4,pass4
  ")

  $lines = $benchListpath.Trim() -split "\n"

  $structuredData = foreach ($line in $lines) {
    $fields = $line -split ','
    [pscustomobject]@{
      Alias        = $fields[0]
      ComputerName = $fields[1]
      Username     = $fields[2]
      Password     = $fields[3]
    }
  }
  # $structuredData | Format-Table -Property * -Wrap -AutoSize
  return $structuredData
}

#-------------------------------------------------- BenchListFromTxt --------------------------------------------------
function BenchListFromTxt {
  $benchListPath = Join-Path $PSScriptRoot 'BenchList.txt'
  $computers = @() # Start empty array for required computers
  Get-Content -Path $benchListPath | ForEach-Object {
    # Split the line by whitespace (you can use -split '\s+' for more control)
    $parts = $_ -split ','
    # Create a hashtable for each computer and add it to the array
    $computers += @{
      Alias        = $parts[0].Trim()
      ComputerName = $parts[1].Trim()
      Username     = $parts[2].Trim()
      Password     = $parts[3].Trim()
    }
  }
  return $computers
}

#-------------------------------------------------- Get Variable Type -------------------------------------------------
# Write-Host "The base type of the variable is: $($currentComputer.GetType().Name)"


#-------------------------------------------------- GetIndexComputerName ----------------------------------------------
function GetIndexComputerName {
  param (
    [Parameter(Mandatory)]
    [Array]$computers, # Array parameter for multiple computers
    [Parameter(Mandatory)]
    [string]$ComputerName     # String parameter for the action to perform
  )
  
  $index = -1
  for ($i = 0; $i -lt $computers.Count; $i++) {
    if ($computers[$i].ComputerName -eq $ComputerName) {
      $index = $i
      break
    }
  }
  # For debugging index
  # if ($index -ge 0) {
  #     Write-Host "Found $ComputerName at index $index"
  # } else {
  #     Write-Host "$ComputerName not found"
  # }
  return $index
}

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
    # $columns.Length # Use it to know real value if you don't get the Active or Disc State
    # Disc=9 Active=10
    # Handle different cases: with or without a session name
    if ($columns.Length -le 9) {
      # Case without SESSIONNAME
      # uif54465                                  2  Disc            .  16/10/2024 03:00 p. m.
      $userId = $columns[1]
      $state = $columns[3]  # STATE is in the third column
    }
    elseif ($columns.Length -ge 10) {
      # Case with SESSIONNAME
      # uif54465              rdp-tcp#0           2  Active          .  16/10/2024 03:00 p. m.
      $userId = $columns[1]
      $state = $columns[4]  # STATE is still in the fourth column
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

#-------------------------------------------------- getIpAddress ------------------------------------------------------
function getIpAddress {
  param (
    [Parameter(Mandatory)]
    [string]$computerName
  )

  # Get current computer IP, these are two options depending the format of the output.
  # $ipAddress = (Test-Connection -ComputerName $($dataBenches[$index].ComputerName) -Count 1).IPv4Address.IPAddressToString
  # Write-Host "IP Address of $computerName is $ipAddress"
  $ipAddress = [System.Net.Dns]::GetHostAddresses($computerName) | Where-Object { $_.AddressFamily -eq 'InterNetwork' }
  $ipAddressString = $ipAddress[0].IPAddressToString
  return $ipAddressString
}

#-------------------------------------------------- Set string to use in Invoke-Command -------------------------------
# Combine the functions into a single string to send in Invoke-Command
$callFunctions = "function GetIndexComputerName {${function:GetIndexComputerName}}`nfunction getUserIdState {${function:getUserIdState}}"
# $callFunctions
