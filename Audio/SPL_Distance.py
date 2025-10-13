import tkinter as tk
from tkinter import ttk
import math

def calcular_spl():
    try:
        sensibilidad = float(entry_sensibilidad.get())
        potencia = float(entry_potencia.get())
        distancia = float(entry_distancia.get())
        bocinas = int(entry_bocinas.get())

        if potencia <= 0 or distancia <= 0 or bocinas <= 0:
            label_resultado.config(text="❌ Todos los valores deben ser mayores que 0.", foreground="red")
            return

        # SPL de una bocina a 1m con la potencia indicada
        spl_1m = sensibilidad + 10 * math.log10(potencia)

        # Pérdida por distancia
        spl_dist = spl_1m - 20 * math.log10(distancia / 1.0)

        # Ganancia por cantidad de bocinas idénticas
        spl_total = spl_dist + 10 * math.log10(bocinas)

        label_resultado.config(
            text=f"SPL por bocina a {distancia:.1f} m: {spl_dist:.2f} dB\n"
                 f"SPL total con {bocinas} bocinas: {spl_total:.2f} dB",
            foreground="black"
        )
    except ValueError:
        label_resultado.config(text="❌ Ingresa solo valores numéricos válidos.", foreground="red")

# --- Ventana principal ---🔊 
root = tk.Tk()
root.title("Calculadora de SPL (Potencia + Distancia + Nº Bocinas)")
root.geometry("430x340")
root.resizable(False, False)

# --- Título ---
ttk.Label(root, text="Calculadora de SPL total con varias bocinas",
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
ttk.Label(frame_inputs, text="Potencia por bocina (W):").grid(row=1, column=0, padx=5, pady=5, sticky="e")
entry_potencia = ttk.Entry(frame_inputs, width=10)
entry_potencia.grid(row=1, column=1, padx=5, pady=5)
entry_potencia.insert(0, "85")

# Distancia
ttk.Label(frame_inputs, text="Distancia (m):").grid(row=2, column=0, padx=5, pady=5, sticky="e")
entry_distancia = ttk.Entry(frame_inputs, width=10)
entry_distancia.grid(row=2, column=1, padx=5, pady=5)
entry_distancia.insert(0, "5")

# Número de bocinas
ttk.Label(frame_inputs, text="Número de bocinas:").grid(row=3, column=0, padx=5, pady=5, sticky="e")
entry_bocinas = ttk.Entry(frame_inputs, width=10)
entry_bocinas.grid(row=3, column=1, padx=5, pady=5)
entry_bocinas.insert(0, "2")

# --- Botón Calcular ---
btn_calcular = ttk.Button(root, text="Calcular SPL total", command=calcular_spl)
btn_calcular.pack(pady=15)

# --- Resultado ---
label_resultado = ttk.Label(root, text="", font=("Segoe UI", 11))
label_resultado.pack(pady=10)

# --- Créditos ---
ttk.Label(root, text="Basado en cálculos acústicos estándar (1W/1m, campo libre)",
          font=("Segoe UI", 8), foreground="gray").pack(side="bottom", pady=5)

# --- Ejecutar GUI ---
root.mainloop()
