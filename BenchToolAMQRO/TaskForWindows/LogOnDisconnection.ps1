# Script to log the date and time when a user ends a remote session and automatically clears last user.
# To use is it's necessary import the task LogCsvOnDisonnection.xml and create the LogOnDisconnection.exe file.
# Add the LogOnDisconnection.exe to the path C:\Tools\BenchTool in the remote bench

# Define the path to the CSV file where activity will be logged
$csvPath = Join-Path $PSScriptRoot "output.csv"
$data = Import-Csv -Path $csvPath
$rowCount = $data.Count - 1
Write-Host "Rows $rowCount" -ForegroundColor Cyan
$data[$rowCount].endState = "Disconected"
$data[$rowCount].endDate = (Get-Date).ToString("yyyy-MM-dd")
$data[$rowCount].endTime = (Get-Date).ToString("HH:mm:ss")
$data | Export-Csv -Path $csvPath -NoTypeInformation

Set-Content -Path "LastUser.txt" -Value ""