# Borra la caché de íconos de Windows si persiste el problema de icono
ie4uinit.exe -show

pyinstaller --onefile --noconsole --icon=SPL_Calculator.ico --add-data "SPL_Calculator.ico;." SPL_Calculator.py

