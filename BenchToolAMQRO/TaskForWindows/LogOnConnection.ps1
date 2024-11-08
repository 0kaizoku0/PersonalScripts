# Script to log the date and time when a user starts a remote session
# To use is it's necessary import the task LogCsvOnConnection.xml and create the LogOnConnection.exe file.
# Add the LogOnConnection.exe to the path C:\Tools\BenchTool in the remote bench
#-------------------------------------------------- Create csv --------------------------------------------------------
# Define the path to the CSV file where activity will be logged
$csvPath = Join-Path $PSScriptRoot "output.csv"

# Define a list to hold rows (each row is a hashtable with column names as keys)
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
