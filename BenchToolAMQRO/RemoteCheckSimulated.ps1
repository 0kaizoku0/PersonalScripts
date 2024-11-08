Write-Host "B07-GM17 : Z1D5147W : 10.247.132.13 : Available : uif54465 : ContiTestBench07"
Write-Host "B08-GM17 : Z1L4726W : 10.247.134.163 : In Use : uif93018 : Continental2023.08"
Write-Host "B05-GM17 : Z1D5082W : 10.247.148.62 : In Use : uif56057 : ContiTestBench05"
Write-Host "B.#-GM17 : Z1L0435W : 10.247.134.235 : Available : uif93014 : Continental123.#"
Write-Host "Bench 12 : Z1D5509W : 10.247.148.96 : In Use : uig48226 : Continental2023.12"
Write-Host "Bench03 : Z1D5545N : 10.247.129.21 : Available : uif92719 : Continental2023.03"
Write-Host "BenchLb : Z1D5150W : 10.247.148.54 : In Use : uig56528 : Temporal123!"

# Define the list of possible states
$states = @("Available", "In Use", "Not Initialized", "Offline")

# Loop to update the variable every 5 seconds
while ($true) {
    # Pick a random state from the list
    $randomState = $states | Get-Random
    # Display the random state
    Write-Output "Current State: $randomState"
    # Wait for 5 seconds before picking a new random state
    Start-Sleep -Seconds 1
}
