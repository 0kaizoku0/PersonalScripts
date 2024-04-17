# Define the destination folder path
$destinationFolder = $PSScriptRoot

# Copy a folder from LocalAppData to the destination folder
Copy-Item -Path "$env:LOCALAPPDATA\LGHUB" -Destination $destinationFolder -Recurse

# Copy a folder from AppData to the destination folder
Copy-Item -Path "$env:APPDATA\G HUB" -Destination $destinationFolder -Recurse
