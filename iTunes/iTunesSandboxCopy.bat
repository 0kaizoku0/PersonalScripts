@echo off
set origen=%SystemDrive%\Sandbox\%UserName%\armandoob\user\current\Music\iTunes\iTunes Media\Music
REM set destino=G:\Music
REM set destino=\\C300\Descargas\Music
set destino=C:\Users\FTW3\OneDrive\Music

REM Eliminar archivo de registro anterior
set "nombre_archivo_log=robocopy.log"
if exist "%nombre_archivo_log%" (
  echo Eliminando archivo de registro anterior...
  del "%nombre_archivo_log%"
  REM Espera 3 segundos
  REM timeout /t 10 /nobreak
 REM pause
)


echo Copiando archivos .m4a, .lrc ...
robocopy "%origen%" "%destino%" *.m4a *.lrc *.m4v /S /XC /MT:20 /R:3 /W:1 /LOG+:robocopy.log /TEE

REM /S                  indica a Robocopy que debe copiar los archivos de forma recursiva, incluyendo los subdirectorios.
REM /MT:32              se establece para utilizar 32 hilos simultáneos durante la copia. Puedes ajustar estos valores según tus preferencias.
REM /R:3 y /W:1         se establecen para permitir hasta 3 intentos de copia con un tiempo de espera de 1 segundo entre intentos. Puedes ajustar estos valores según tus preferencias.
REM /LOG+:robocopy.log  se agrega para generar un registro de la actividad de copia en un archivo llamado "robocopy.log".
REM /XC                 se establece para excluir los archivos que ya existen en el destino.
REM /TEE                Esta opción permite mostrar el progreso en la ventana de comandos mientras se copian los archivos. Los registros de copia también se guardarán en el archivo de registro especificado.

pause