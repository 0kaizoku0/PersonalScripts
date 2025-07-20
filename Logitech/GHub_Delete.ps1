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



# Delete a folder from LocalAppData
Remove-Item -Path "$env:LOCALAPPDATA\LGHUB" -Recurse -Force

# Delete a folder from AppData
Remove-Item -Path "$env:APPDATA\G HUB" -Recurse -Force
Remove-Item -Path "$env:APPDATA\lghub" -Recurse -Force
Write-Host
Write-Host
Write-Host "Deleted Logitech G Hub configurations"
Write-Host
Write-Host

