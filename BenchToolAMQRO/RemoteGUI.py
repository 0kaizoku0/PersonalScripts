import tkinter as tk
from tkinter import ttk
import threading
import subprocess
import time
import re

# Function to run PowerShell script continuously
def run_powershell_script():
    while True:
        # Run the PowerShell script and capture the output
        process = subprocess.Popen(["powershell", "-Command", "Path\\To\\YourScript.ps1"],
                                   stdout=subprocess.PIPE, text=True)
        output, _ = process.communicate()

        # Update the GUI with the new output
        update_gui(output)
        
        # Run every few seconds (adjust as needed)
        time.sleep(5)

# Function to update the GUI with the latest output
def update_gui(output):
    # Clear previous content in the GUI
    for label in labels:
        label['text'] = ""

    # Parse output for display
    lines = output.strip().splitlines()
    for i, line in enumerate(lines):
        match = re.match(r"^(.*) : (.*) : (.*) : (.*) : .* : .*", line)
        if match:
            alias, computer_name, ip_address, user_state = match.groups()
            labels[i][0]['text'] = alias
            labels[i][1]['text'] = computer_name
            labels[i][2]['text'] = ip_address
            labels[i][3]['text'] = user_state

# Initialize GUI window
root = tk.Tk()
root.title("PowerShell Script Output")

# Create labels for each Alias, ComputerName, IP, and userState
labels = []
for i in range(4):  # Assuming 4 entries as per the sample output
    alias_label = ttk.Label(root, text="Alias")
    computer_name_label = ttk.Label(root, text="ComputerName")
    ip_label = ttk.Label(root, text="IP Address")
    state_label = ttk.Label(root, text="User State")

    alias_label.grid(row=i, column=0, padx=5, pady=5)
    computer_name_label.grid(row=i, column=1, padx=5, pady=5)
    ip_label.grid(row=i, column=2, padx=5, pady=5)
    state_label.grid(row=i, column=3, padx=5, pady=5)

    labels.append([alias_label, computer_name_label, ip_label, state_label])

# Start PowerShell script in a separate thread
thread = threading.Thread(target=run_powershell_script, daemon=True)
thread.start()

# Start the GUI event loop
root.mainloop()
