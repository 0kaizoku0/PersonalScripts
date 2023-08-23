# Ruta del script
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath

# Ruta del archivo de salida
$outputFilePath = Join-Path -Path $scriptDirectory -ChildPath "ArchivoDeSalidaSD.txt"

# Ruta de la carpeta de búsqueda
#$searchFolder = "C:\Users\FTW3\OneDrive\iTunes\iTunes Media\Music"
$searchFolder = "C:\Users\FTW3\OneDrive\Apple\Music"

# Buscar archivos .m4a de manera recursiva
$files = Get-ChildItem -Path $searchFolder -Filter "*.m4a" -Recurse | Select-Object -ExpandProperty FullName

# Guardar la lista de archivos en un archivo de texto
$files | Out-File -FilePath $outputFilePath

# Abrir el archivo con una aplicación específica (por ejemplo, Bloc de notas)
$application = "notepad++.exe"
Start-Process -FilePath $application -ArgumentList $outputFilePath
