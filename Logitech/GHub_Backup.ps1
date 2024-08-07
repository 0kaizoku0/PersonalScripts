# Define the destination folder path
# $destinationFolder = $PSScriptRoot
$sourceFolder1 = "$PSScriptRoot\Local\LGHUB"
$sourceFolder2 = "$PSScriptRoot\Roaming\G HUB"
$sourceFolder3 = "$PSScriptRoot\Roaming\lghub"

Remove-Item -Path $sourceFolder1 -Recurse -Force
Remove-Item -Path $sourceFolder2 -Recurse -Force
Remove-Item -Path $sourceFolder3 -Recurse -Force

# Copy a folder from LocalAppData to the destination folder
Copy-Item -Path "$env:LOCALAPPDATA\LGHUB" -Destination $sourceFolder1 -Recurse

# Copy a folder from AppData to the destination folder
Copy-Item -Path "$env:APPDATA\G HUB" -Destination $sourceFolder2 -Recurse
Copy-Item -Path "$env:APPDATA\lghub" -Destination $sourceFolder3 -Recurse
