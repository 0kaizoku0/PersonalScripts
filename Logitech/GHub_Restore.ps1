# Define the destination folder path
$sourceFolder1 = "$PSScriptRoot\LGHUB"
$destinationFolder1 = "$env:LOCALAPPDATA\LGHUB"
$sourceFolder2 = "$PSScriptRoot\G HUB"
$destinationFolder2 = "$env:APPDATA\G HUB"

# Copy a folder from sourceFolder1 to the destinationFolder1
Copy-Item -Path $sourceFolder1 -Destination $destinationFolder1 -Recurse -Force

# Copy a folder from sourceFolder2 to the destinationFolder2
Copy-Item -Path $sourceFolder2 -Destination $destinationFolder2 -Recurse -Force
