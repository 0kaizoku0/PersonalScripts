import tkinter as tk
from tkinter import messagebox  # To show the pop-up message
from tkinter import ttk  # Import ttk for the Progressbar
from tkinter import filedialog
import subprocess
import threading
import queue
import time
import sys
import os

# Determine if the script is running as an executable
if getattr(sys, 'frozen', False):
    # Path for the executable
    base_path = sys._MEIPASS
else:
    # Path when running from script
    base_path = os.path.dirname(os.path.abspath(__file__))

# Use the base_path to access bundled files
bench_list = os.path.join(base_path, 'BenchList.txt')
remote_check_multiple_ps1 = os.path.join(base_path, 'RemoteCheckMultipleBenchesMultiThread.ps1')

# Global variable to count updates after pressing the "Connect" button
update_counter = 0
selected_computer_status = None
top_level_windows = []  # List to keep track of all top-level windows (including popups)


# Function to create the waiting popup
def show_waiting_popup():
    popup = tk.Toplevel(root)  # Create a popup window
    popup.title("Please Wait")
    popup.geometry("300x100")  # Set the size of the popup window
    popup.config(bg="lightgray")  # Set the background color

    # Center the popup window
    x = root.winfo_x() + (root.winfo_width() // 2) - 150  # 150 is half of popup width (300/2)
    y = root.winfo_y() + (root.winfo_height() // 2) - 50   # 50 is half of popup height (100/2)
    popup.geometry(f"+{x}+{y}")  # Set the position of the popup

    # Label for the message
    popup_label = tk.Label(popup, text="Double checking availability...", bg="lightgray")
    popup_label.pack(pady=10, padx=2)

    # Create a loading bar (Progressbar)
    loading_bar = ttk.Progressbar(popup, mode='indeterminate')
    loading_bar.pack(pady=10, padx=2, fill=tk.X)  # Fill the bar horizontally
    loading_bar.start()  # Start the loading animation

    top_level_windows.append(popup)  # Track the popup window
    return popup
# Ends show_waiting_popup

# Function to create the message box in the center
def show_centered_message(title, message):
    # Create a Toplevel window for the custom message box
    message_box = tk.Toplevel(root)
    message_box.title(title)

    # Set the size of the message box
    message_box.geometry("250x100")  # Width x Height

    # Center the message box
    x = root.winfo_x() + (root.winfo_width() // 2) + 125  # 125 is half of message box width (250/2)
    y = root.winfo_y() + (root.winfo_height() // 2) + 100   # 50 is half of message box height (100/2)
    message_box.geometry(f"+{x}+{y}")  # Set the position of the message box

    # Add the message label
    message_label = tk.Label(message_box, text=message)
    message_label.pack(pady=10)

    # Add an OK button to close the message box
    ok_button = tk.Button(message_box, text="OK", command=message_box.destroy, width=10, height=1)
    ok_button.pack(pady=(0, 5))  # Add some padding

    message_box.transient(root)  # Make the message box a transient window
    message_box.grab_set()  # Grab input focus
    # TODO: check if wait until OK is required in all cases
    # root.wait_window(message_box)  # Wait for the message box to close
# Ends show_centered_message


# Function to close the waiting popup
def close_all_popups():
    for window in top_level_windows:
        if window:  # Check if the window is not already destroyed
            window.destroy()
    top_level_windows.clear()  # Clear the list after destroying all popups


# Function to run the PowerShell script and get the output
def get_powershell_output(output_queue):
    # Define the path to your PowerShell script
    # Command to run the PowerShell script
    command = ["pwsh.exe", "-WindowStyle", "Hidden", "-ExecutionPolicy", "Bypass", "-File", remote_check_multiple_ps1]
    while True:  # Continuously run the script in this thread
        try:
            # Run the command
            result = subprocess.Popen(
                command,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                creationflags=0x08000000  # creationflags=subprocess.CREATE_NO_WINDOW
                )
            stdout_output, stderr_output = result.communicate()
            # Decode the output from bytes to string
            stdout_output = stdout_output.decode('utf-8')
            stderr_output = stderr_output.decode('utf-8')
            # Return the output of the script
            if stderr_output:
                print(f"Errors occurred: {stderr_output}")

            # Put the output into the queue for the main thread to read
            output_queue.put(stdout_output)
        except Exception as e:
            print(f"An error occurred: {e}")

        # Sleep x seconds before running the script again
        time.sleep(1)

# Function to update the GUI with the output from the queue
def update_gui():
    global update_counter, selected_computer_status
    try:
        # Check if there are new messages in the queue
        while True:
            output = output_queue.get_nowait()  # Non-blocking get from the queue
            process_output(output)
            # Check if connect button was pressed and increment the update counter
            if connect_initiated:
                update_counter += 1
                selected_computer = selected_ip.get()
                print(f"Selected Computer: {selected_computer}: {selected_computer_status}")
                if selected_computer in benchStatus:
                    print(f"{selected_computer} exists in labels")
                    selected_computer_status = benchStatus[selected_computer]#.cget("text")  # Get the current status
                    print(f"Current status of {selected_computer}: {selected_computer_status}")

                # Lock File mode double check
                if (selected_computer_status == "Available" or selected_computer_status == "Not Initialized") and update_counter >= 1:
                    # Run the PowerShell command
                    command = ["pwsh.exe", "-WindowStyle", "Hidden", "-ExecutionPolicy", "Bypass", "-Command", "$env:USERNAME"]
                    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

                    # Decode the output and strip whitespace
                    username = result.stdout.decode('utf-8').strip()

                    # Construct the remote path using the variables
                    remote_path = rf"\\{selected_computer}\BenchTool\LastUser.txt"
                    lockFilePath = rf"\\{selected_computer}\BenchTool\RDP_Lock.txt"
                    if os.path.exists(lockFilePath):
                      show_centered_message("Bench in Use", "Someone else requested before")  # Show custom pop-up
                    else:
                        print(f"The file {lockFilePath} does not exist, can proceed.")
                        # Create lockFile for this request
                        with open(lockFilePath, 'w') as file:
                          file.write(f"Locked\n")
                        print(f"{lockFilePath} has been created successfully.")
                        connect()  # Proceed with connection
                        with open(remote_path, 'w') as file:
                          file.write(f"{username}")
                        print(f"{username} using {selected_computer}")
                        close_all_popups()
                        time.sleep(3) # To keep the file 3 seconds
                        os.remove(lockFilePath)
                        print(f"{lockFilePath} has been removed successfully.")
                    reset_connect_state()  # Reset the connection state
                else:
                    close_all_popups()
                    show_centered_message("Bench in Use", "Can't request connection")  # Show custom pop-up
                    reset_connect_state()  # Reset the connection state
                # Lock File mode double check
    except queue.Empty:
        pass  # No new output to process

    # Schedule the next GUI update
    root.after(1000, update_gui)  # Check every x milliseconds

# Reset the connection state (reset counter and flags)
def reset_connect_state():
    global update_counter, connect_initiated
    update_counter = 0
    connect_initiated = False



# Dictionary to hold user and password pairs
user_passwords = {}
benchStatus = {}

# Global variable for computerName
computerName = ""

# Function to process the output and update labels
def process_output(output):
    # Read the content of the LastUser
    # Example output format to be splitted:
    # Computer08 : Name08 : 192.168.1.8 : in use : user : password
    lines = output.strip().split('\n')
    # Row index tracker to place labels correctly in the grid
    row = 0
    # Add column headers
    tk.Label(frame, text="Computer : Name : IP", width=30, font=("Arial", 10, "bold")).grid(row=0, column=0, padx=2, pady=5)
    tk.Label(frame, text="Status", width=15, font=("Arial", 10, "bold")).grid(row=0, column=1, padx=2, pady=5)
    tk.Label(frame, text="Select", width=10, font=("Arial", 10, "bold")).grid(row=0, column=2, padx=2, pady=5)
    # Start from row 1 for data (since row 0 is the header)
    row = 1
    # Loop through each line and update the labels
    for line in lines:
        parts = line.split(" : ")
        if len(parts) == 6:  # Expecting six parts: computer, name, ip, status, uid, pswd
            computer, name, ip, status, uid, pswd = parts
            shared_folder = "BenchTool"        # Replace with the actual shared folder name
            file_name = "BenchTool\LastUser.txt"             # Replace with the actual file name
            remote_path = f"\\\\{name}\{file_name}"
            # print(f"Path type: {type(remote_path)}")  # Should print: <class 'str'>
            # print(f"Remote Path: {remote_path}")  # Display the constructed path
            # print(remote_path)
            try:
                with open(remote_path, 'r') as file:
                    content = file.read()  # Read the entire file content into a variable
                    print(content)          # Print the content (or you can assign it to a variable)
            except Exception as e:
                content = "Unknown"
                print(f"Error reading the file: {e}")

            # Store the user and password for this computer
            user_passwords[ip] = (uid, pswd)
            benchStatus[ip]=(status)
            # Normalize the status text strip() does " Available"→"Available"
            status = status.strip()
            # Check if the computer is in the labels dictionary
            if computer in labels:
                if labels[computer] is None:  # If label hasn't been created yet
                    if status=="In Use":
                      text_label=status + " by " + content
                    else:
                      text_label=status
                    # Add a new row for this computer
                    tk.Label(frame, width=30, text=f"{computer} : {name} : {ip}").grid(row=row, column=0, padx=2, pady=5)
                    # status_label.config(text="")
                    # Create the status label for "In use", "Available", "Not Initialized" or "Offline"
                    status_label = tk.Label(frame, text=text_label, width=15, fg={"Available": "green", "In Use": "red", "Not Initialized": "orange"}.get(status, "gray"))
                    status_label.grid(row=row, column=1, padx=2, pady=5)
                    radio_button = tk.Radiobutton(frame, text=f"{name}", variable=selected_ip, value=ip)
                    radio_button.grid(row=row, column=2, padx=2, pady=5)
                    # Store the status label in the dictionary
                    labels[computer] = status_label
                else:
                    if status=="In Use":
                      text_label=status + " by " + content
                    else:
                      text_label=status
                    # Update the existing label's text and color
                    labels[computer].config(text=text_label, fg={"Available": "green", "In Use": "red", "Not Initialized": "orange"}.get(status, "gray"))
            else:
                if status=="In Use":
                  text_label=status + " by " + content
                else:
                  text_label=status
                # Add the computer to the dictionary if it's not present
                tk.Label(frame, width=30, text=f"{computer} : {name} : {ip}").grid(row=row, column=0, padx=2, pady=5)
                status_label = tk.Label(frame, text=text_label, width=15, fg={"Available": "green", "In Use": "red", "Not Initialized": "orange"}.get(status, "gray"))
                status_label.grid(row=row, column=1, padx=2, pady=5)
                radio_button = tk.Radiobutton(frame, text=f"{name}", variable=selected_ip, value=ip)
                radio_button.grid(row=row, column=2, padx=2, pady=5)
                # Store the status label in the dictionary
                labels[computer] = status_label
                # print(f"status_label {status}")
                print(f"Add {computer} to the list")
            # Increment the row index for each computer
            row += 1

# Function to handle pressing the "Connect" button
def on_connect_button_press():
    popup = show_waiting_popup()  # Show the waiting popup
    global connect_initiated
    selected_computer = selected_ip.get()
    if selected_computer in user_passwords:
        print(f"Checking status of {selected_computer}. Please wait...")
        connect_initiated = True  # Flag to initiate the connection attempt after updates

def add_credentials(ip, username, password):
    # Use cmdkey to store the credentials in the Credential Manager
    cmdkey_command = f'cmdkey /generic:{ip} /user:{username} /pass:{password}'
    subprocess.run(cmdkey_command, shell=True)

def connect_rdp(ip):
    # Use mstsc to connect without requiring manual login
    rdp_command = f'mstsc /v:{ip}'
    subprocess.Popen(rdp_command, shell=True)

# Function to connect to the selected computer
def connect():
    selected_computer = selected_ip.get()
    if selected_computer in user_passwords:
        username, password = user_passwords[selected_computer]
        # Here you can add the logic to use the selected IP, username, and password
        add_credentials(selected_computer, username, password)  # Store credentials
        print(f"Connecting to {selected_computer} with user {username} and password {password}")
        # Example command to connect via RDP
        # rdp_command = f'mstsc /v:{selected_computer}'
        # Run the command to establish RDP connection
        # subprocess.Popen(rdp_command, shell=True)
        connect_rdp(selected_computer)  # Connect using stored credentials
    else:
        print("No user/password found for the selected computer.")

#-------------------------------------------------- Robocopy functions ------------------------------------------------
def run_robocopy():
    remote_computer = selected_ip.get()
    local_folder = local_folder_entry.get()
    # remote_computer = computerName
    print(f"Selected {remote_computer} to copy files")
    remote_folder = remote_folder_entry.get()
    remote_path = f"\\\\{remote_computer}\\{remote_folder}"
    # Robocopy command
    robocopy_command = f'robocopy "{local_folder}" "{remote_path}" *.c *.h *.py *.ps1 /S /MIR /MT:32 /R:3 /W:1 /TEE'
    # Run robocopy in a new command window
    threading.Thread(target=lambda: subprocess.Popen(f'cmd /c "{robocopy_command}"', shell=True)).start()

def select_local_folder():
    folder_path = filedialog.askdirectory()
    local_folder_entry.delete(0, tk.END)
    local_folder_entry.insert(0, folder_path)
#-------------------------------------------------- Robocopy functions ------------------------------------------------

#-------------------------------------------------- GUI Setup ---------------------------------------------------------
# Create the main Tkinter window
root = tk.Tk()
root.title("Computer Status Monitor")
# Set the size of the main window (width x height)
root.geometry("500x370")

# Create a frame to hold the computer status labels
frame = tk.Frame(root)
frame.pack(pady=10)

# Dictionary to hold status labels
labels = {}

# Queue for communication between threads
output_queue = queue.Queue()

# Flag to indicate when the "Connect" button was pressed
connect_initiated = False

# Variable for selected IP with any default value to not enable radio buttons when app starts
selected_ip = tk.StringVar(value="111.222.333.123")

# Connect button
connect_button = tk.Button(root, text="Connect", command=on_connect_button_press)
connect_button.pack(pady=(5, 5))# pixels of padding above and pixels below the button

# Start the thread to run the PowerShell script
threading.Thread(target=get_powershell_output, args=(output_queue,), daemon=True).start()


#-------------------------------------------------- GUI Robocopy ------------------------------------------------------
# Create a frame to hold the local folder components in a single row
local_folder_frame = tk.Frame(root)
local_folder_frame.pack(padx=5, pady=5, anchor='w')  # Pack the frame itself
# Local folder selection
# Add the elements to the frame, aligning them side-by-side
tk.Label(local_folder_frame, text="Local Folder:", width=15).pack(side='left', padx=5)
local_folder_entry = tk.Entry(local_folder_frame, width=50)
local_folder_entry.pack(side='left', padx=5)
tk.Button(local_folder_frame, text="Browse", command=select_local_folder).pack(side='left', padx=5)

# Remote folder input
# Create a frame to hold the remote folder components in a single row
remote_folder_frame = tk.Frame(root)
remote_folder_frame.pack(padx=5, pady=5, anchor='w')  # Pack the frame itself

# Add the label and entry to the frame, aligning them side-by-side
tk.Label(remote_folder_frame, text="Remote Folder:", width=15).pack(side='left', padx=5)
remote_folder_entry = tk.Entry(remote_folder_frame, width=50)
remote_folder_entry.pack(side='left', padx=5)


# Run button
tk.Button(root, text="Run Robocopy", command=run_robocopy).pack(pady=10)

#-------------------------------------------------- GUI Setup ---------------------------------------------------------

show_centered_message("Bench Tool", "Wait while bench List is loading.")

# Start the GUI update loop
update_gui()

close_all_popups()




# Start the Tkinter event loop
root.mainloop()
