$numID = Get-Date -Format "yyyyMMdd_HHmmssffff"
pyinstaller --onefile --windowed --add-data "BenchList.txt;." --add-data "Functions.ps1;." --add-data "RemoteCheckMultipleBenchesV2.ps1;." mainProjectRoboCopy.py

$fileName = "mainProjectRoboCopy.exe"
$oldFilePath = "dist\$fileName"
$baseName = "BenchTool"
$extension = ".exe"
$newFileName = $baseName + "_$numID" + $extension

Rename-Item -Path $oldFilePath -NewName $newFileName

Write-Host "$newFileName created successfuly." -ForegroundColor Green