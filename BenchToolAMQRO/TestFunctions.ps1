# # This file is to test the functions defined in Functions.ps1
# # Call the file to use functions
# . (Join-Path -Path $PSScriptRoot -ChildPath 'Functions.ps1')

# Write-Host "function BenchList" -ForegroundColor Green
# # Call the function
# $dataTest = BenchList
# # Get the number of elements in the structured data
# $numberOfElements = $dataTest.Count
# Write-Host $numberOfElements -ForegroundColor Red
# # Print Alias2
# Write-Host $dataTest[2].Alias -ForegroundColor White -BackgroundColor DarkBlue
# # Print all the list
# $dataTest | Format-Table -Property * -Wrap -AutoSize



# Write-Host "function BenchListFromTxt" -ForegroundColor Green
# # Call the function
# $computers = BenchListFromTxt
# Write-Host $computers.Alias
# Write-Host $computers.ComputerName
# Write-Host $computers.Username
# Write-Host $computers.Password

# # Output the array to verify
# $computers[0].Alias

# Write-Host "function GetIndexComputerName" -ForegroundColor Green
# GetIndexComputerName -ComputerName $computers[0].ComputerName -computers $computers


# Write-Host "function getUserIdState" -ForegroundColor Green
# $quserOutput = quser 2>&1
# $userIdState = getUserIdState -quserOutput $quserOutput
# Write-Host "User: $($userIdState[0]) State: $($userIdState[1])"


# #-------------------------------------------------- Simulate state detection ------------------------------------------
# Write-Host "Simulate state detection" -ForegroundColor Green

# # Initialize variables
# $currentState = 0  # Initial state
# $previousState = $currentState  # Store the initial state as the previous state

# # Simulate the state changes in a loop
# for ($i = 1; $i -le 10; $i++) {
#     # Simulate a change in the 'currentState' variable (switch between 0 and 1)
#     $currentState = -not $currentState  # Toggle between 0 and 1

#     # Check if the current state is different from the previous state
#     if ($currentState -ne $previousState) {
#         Write-Output "State changed from $previousState to $currentState"
#         # Update the previous state to the current state
#         $previousState = $currentState
#     } else {
#         Write-Output "No state change; current state is still $currentState"
#     }

#     # Pause briefly for demonstration purposes
#     Start-Sleep -Milliseconds 500
# }

# #-------------------------------------------------- Understanding CSV file ------------------------------------------
# Define the path to the CSV file
$csvPath = "output.csv"
Remove-Item $csvPath -Force
Write-Host "Csv deleted"
# Create a custom object with the desired headers and empty values
$headers = [PSCustomObject]@{
  UserName  = " " # Needs to have anything to read data when import
  initState = ""
  initDate  = ""
  initTime  = ""
  endState  = ""
  endDate   = ""
  endTime   = ""
}
# Export the headers to a new CSV file
$headers | Export-Csv -Path $csvPath -NoTypeInformation

# Define data to add
$newRow = @()
$newRow = [PSCustomObject]@{
  UserName  = "JohnDoe"
  initState = "Active"
  initDate  = (Get-Date).ToString("yyyy-MM-dd")
  initTime  = (Get-Date).ToString("HH:mm:ss")
  endState  = "Inactive"
  endDate   = (Get-Date).AddHours(1).ToString("yyyy-MM-dd")
  endTime   = (Get-Date).AddHours(1).ToString("HH:mm:ss")
}
# Adding new data
# Append the new row to the CSV file
$newRow | Export-Csv -Path $csvPath -Append -NoTypeInformation
$newRow | Export-Csv -Path $csvPath -Append -NoTypeInformation
$newRow | Export-Csv -Path $csvPath -Append -NoTypeInformation
$newRow | Export-Csv -Path $csvPath -Append -NoTypeInformation
# Import the CSV file into an array of objects
$data = Import-Csv -Path $csvPath
# Set index in the last data
$lastIndex = $data.Count - 1
$data[$lastIndex].UserName = 5
$data[$lastIndex].initState = 5
$data[$lastIndex].initTime = 5
$data[$lastIndex].endState = 5

$data | Export-Csv -Path $csvPath -NoTypeInformation
# #-------------------------------------------------- Understanding CSV file ------------------------------------------