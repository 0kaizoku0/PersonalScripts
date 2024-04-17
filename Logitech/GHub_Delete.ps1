# Delete a folder from LocalAppData
Remove-Item -Path "$env:LOCALAPPDATA\LGHUB" -Recurse -Force

# Delete a folder from AppData
Remove-Item -Path "$env:APPDATA\G HUB" -Recurse -Force
Remove-Item -Path "$env:APPDATA\lghub" -Recurse -Force