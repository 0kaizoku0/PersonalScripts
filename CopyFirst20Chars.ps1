### Example constants for source and destination folders
$DEFAULT_SOURCE = "C:\Example\SourceFolder"
$DEFAULT_DEST = "C:\Example\DestinationFolder"

param(
    [Parameter(Mandatory=$false)]
    [string]$SourceFolder = $DEFAULT_SOURCE,
    [Parameter(Mandatory=$false)]
    [string]$DestinationFolder = $DEFAULT_DEST
)

if (!(Test-Path $SourceFolder)) {
    Write-Error "Source folder does not exist: $SourceFolder"
    exit 1
}

if (!(Test-Path $DestinationFolder)) {
    New-Item -ItemType Directory -Path $DestinationFolder | Out-Null
}

Get-ChildItem -Path $SourceFolder -File | ForEach-Object {
    $sourceFile = $_.FullName
    $destFile = Join-Path $DestinationFolder $_.Name
    $content = Get-Content -Path $sourceFile -Raw
    $shortContent = if ($content.Length -gt 20) { $content.Substring(0, 20) } else { $content }
    Set-Content -Path $destFile -Value $shortContent
}

Write-Host "Copied all files from $SourceFolder to $DestinationFolder with only the first 20 characters of each file."
