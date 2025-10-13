import tkinter as tk
from tkinter import ttk
import math

def calcular_spl():
    try:
        sensibilidad = float(entry_sensibilidad.get())
        potencia = float(entry_potencia.get())
        distancia = float(entry_distancia.get())

        if potencia <= 0 or distancia <= 0:
            label_resultado.config(text="❌ Potencia y distancia deben ser mayores que 0.")
            return

        # SPL a 1m según la potencia aplicada
        spl_1m = sensibilidad + 10 * math.log10(potencia)

        # Pérdida por distancia (ley del inverso del cuadrado)
        spl_final = spl_1m - 20 * math.log10(distancia / 1.0)

        label_resultado.config(
            text=f"SPL estimado a {distancia:.2f} m:\n{spl_final:.2f} dB",
            foreground="black"
        )
    except ValueError:
        label_resultado.config(text="❌ Ingresa solo valores numéricos.", foreground="red")

# --- Ventana principal ---
root = tk.Tk()
root.title("Calculadora de SPL con Potencia y Distancia")
root.geometry("400x300")
root.resizable(False, False)

# --- Título --- 🔊
ttk.Label(root, text="Calculadora de SPL (Potencia + Distancia)", 
          font=("Segoe UI", 12, "bold")).pack(pady=10)

# --- Frame de entradas ---
frame_inputs = ttk.Frame(root)
frame_inputs.pack(pady=10)

# Sensibilidad
ttk.Label(frame_inputs, text="Sensibilidad (dB @1W/1m):").grid(row=0, column=0, padx=5, pady=5, sticky="e")
entry_sensibilidad = ttk.Entry(frame_inputs, width=10)
entry_sensibilidad.grid(row=0, column=1, padx=5, pady=5)
entry_sensibilidad.insert(0, "93")

# Potencia
ttk.Label(frame_inputs, text="Potencia aplicada (W):").grid(row=1, column=0, padx=5, pady=5, sticky="e")
entry_potencia = ttk.Entry(frame_inputs, width=10)
entry_potencia.grid(row=1, column=1, padx=5, pady=5)
entry_potencia.insert(0, "85")

# Distancia
ttk.Label(frame_inputs, text="Distancia (m):").grid(row=2, column=0, padx=5, pady=5, sticky="e")
entry_distancia = ttk.Entry(frame_inputs, width=10)
entry_distancia.grid(row=2, column=1, padx=5, pady=5)
entry_distancia.insert(0, "5")

# --- Botón Calcular ---
btn_calcular = ttk.Button(root, text="Calcular SPL", command=calcular_spl)
btn_calcular.pack(pady=10)

# --- Resultado ---
label_resultado = ttk.Label(root, text="", font=("Segoe UI", 12))
label_resultado.pack(pady=10)

# --- Ejecutar GUI ---
root.mainloop()
