import tkinter as tk
from tkinter import filedialog
import subprocess
import threading

def run_robocopy():
    local_folder = local_folder_entry.get()
    remote_computer = remote_computer_entry.get()
    remote_folder = remote_folder_entry.get()
    remote_path = f"\\\\{remote_computer}\\{remote_folder}"
    
    # Robocopy command
    robocopy_command = f'robocopy "{local_folder}" "{remote_path}" /S /DCOPY:DA /COPY:DAT /COMPRESS /MT:32 /R:3 /W:1'
    
    # Run robocopy in a new command window
    threading.Thread(target=lambda: subprocess.Popen(f'cmd /c "{robocopy_command}"', shell=True)).start()

def select_local_folder():
    folder_path = filedialog.askdirectory()
    local_folder_entry.delete(0, tk.END)
    local_folder_entry.insert(0, folder_path)

# GUI setup
root = tk.Tk()
root.title("Robocopy GUI")

# Local folder selection
tk.Label(root, text="Local Folder:").grid(row=0, column=0, padx=5, pady=5)
local_folder_entry = tk.Entry(root, width=50)
local_folder_entry.grid(row=0, column=1, padx=5, pady=5)
tk.Button(root, text="Browse", command=select_local_folder).grid(row=0, column=2, padx=5, pady=5)

# Remote computer input
tk.Label(root, text="Remote Computer:").grid(row=1, column=0, padx=5, pady=5)
remote_computer_entry = tk.Entry(root, width=50)
remote_computer_entry.grid(row=1, column=1, padx=5, pady=5)

# Remote folder input
tk.Label(root, text="Remote Folder:").grid(row=2, column=0, padx=5, pady=5)
remote_folder_entry = tk.Entry(root, width=50)
remote_folder_entry.grid(row=2, column=1, padx=5, pady=5)

# Run button
tk.Button(root, text="Run Robocopy", command=run_robocopy).grid(row=3, column=0, columnspan=3, pady=10)

root.mainloop()
