import tkinter as tk
from tkinter import ttk
import math
import os
import sys
import ctypes


def calcular_spl():
    try:
        sensibilidad = float(entry_sensibilidad.get())
        potencia = float(entry_potencia.get())
        if potencia <= 0:
            resultado_var.set("La potencia debe ser mayor que 0.")
            return

        spl_max = sensibilidad + 10 * math.log10(potencia)
        resultado_var.set(f"SPL Máximo: {spl_max:.2f} dB SPL")
    except ValueError:
        resultado_var.set("Ingrese valores numéricos válidos.")

def ruta_recurso(relative_path):
    """Obtiene ruta absoluta (compatible con PyInstaller)"""
    try:
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")
    return os.path.join(base_path, relative_path)

# Mostrar icono en la barra de tareas (truco real)
myappid = 'miapp.spl.calculadora.1.0'
ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID(myappid)

# Ventana oculta
root = tk.Tk()
root.withdraw()

# Ventana visible principal
main_window = tk.Toplevel()
main_window.title("Calculadora de SPL Máximo")
main_window.geometry("350x200")
main_window.resizable(False, False)
main_window.protocol("WM_DELETE_WINDOW", root.quit)

# Establecer icono
icon_path = ruta_recurso("SPL_Calculator.ico")
if os.path.exists(icon_path):
    main_window.iconbitmap(icon_path)

# Estilo
style = ttk.Style()
style.configure("TLabel", font=("Arial", 12))
style.configure("TButton", font=("Arial", 12))
style.configure("TEntry", font=("Arial", 12))

# Widgets
ttk.Label(main_window, text="Sensibilidad (dB @1W/1m):").pack(pady=(10, 0))
entry_sensibilidad = ttk.Entry(main_window)
entry_sensibilidad.pack()

ttk.Label(main_window, text="Potencia máxima (W RMS):").pack(pady=(10, 0))
entry_potencia = ttk.Entry(main_window)
entry_potencia.pack()

ttk.Button(main_window, text="Calcular SPL", command=calcular_spl).pack(pady=10)

resultado_var = tk.StringVar()
ttk.Label(main_window, textvariable=resultado_var, foreground="blue").pack(pady=5)

# Ejecutar
main_window.mainloop()
