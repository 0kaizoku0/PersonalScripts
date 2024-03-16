# Ruta del script
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDirectory = Split-Path $scriptPath

# Ruta del archivo de salida
$outputFilePath = Join-Path -Path $scriptDirectory -ChildPath "ArchivoDeSalida.txt"

# Ruta de la carpeta de b�squeda
#$searchFolder = "C:\Sandbox\FTW3\itunes_m\user\current\Music\iTunes\iTunes Media\Music"
#$searchFolder = "C:\Users\FTW3\OneDrive\iTunes\iTunes Media\Music"
$searchFolder = "C:\Sandbox\FTW3\armandoob\user\current\Music\iTunes\iTunes Media\Music"

# Buscar archivos .m4a de manera recursiva
$files = Get-ChildItem -Path $searchFolder -Filter "*.m4a" -Recurse | Select-Object -ExpandProperty FullName

# Guardar la lista de archivos en un archivo de texto
$files | Out-File -FilePath $outputFilePath

# Abrir el archivo con una aplicaci�n espec�fica (por ejemplo, Bloc de notas)
$application = "notepad++.exe"
Start-Process -FilePath $application -ArgumentList $outputFilePath

