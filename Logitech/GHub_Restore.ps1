# Clear command window
Clear-Host
# Kill processes related to G Hub
$processesToKill = @("lghub", "lghub_agent", "lghub_system_tray", "lghub_updater")

foreach ($name in $processesToKill) {
    if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
        Stop-Process -Name $name -Force
        Write-Host "Killed process: $name"
    } else {
        Write-Host "Process not running: $name"
    }
}


# Define the destination folder path
$sourceFolder1 = "$PSScriptRoot\Local\LGHUB"
$sourceFolder2 = "$PSScriptRoot\Roaming\G HUB"
$sourceFolder3 = "$PSScriptRoot\Roaming\lghub"
$destinationFolder1 = "$env:LOCALAPPDATA"
$destinationFolder2 = "$env:APPDATA"
$destinationFolder3 = "$env:APPDATA"


# Copy a folder from sourceFolder1 to the destinationFolder1
Copy-Item -Path $sourceFolder1 -Destination $destinationFolder1 -Recurse -Force

# Copy a folder from sourceFolder2 to the destinationFolder2
Copy-Item -Path $sourceFolder2 -Destination $destinationFolder2 -Recurse -Force
Copy-Item -Path $sourceFolder3 -Destination $destinationFolder3 -Recurse -Force
