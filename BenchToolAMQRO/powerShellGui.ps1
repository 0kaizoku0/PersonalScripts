# Load Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to parse and format data
function Format-Output {
    param($output)
    $filteredData = @()

    foreach ($line in $output) {
        $fields = $line -split ' : '
        # Only select Alias, ComputerName, ipAddress, userState
        $filteredData += "$($fields[0]) : $($fields[1]) : $($fields[2]) : $($fields[3])"
    }
    return $filteredData
}

# Function to update ListBox with new data
function Update-ListBox {
    $job = Get-Job -Name "DataFetcherJob"
    if ($job.State -eq 'Completed') {
        # Get the script output
        $output = Receive-Job -Job $job
        $filteredData = Format-Output -output $output

        # Clear and update ListBox with new data
        $listBox.Items.Clear()
        $listBox.Items.AddRange($filteredData)
        
        # Restart the job to fetch new data
        Start-NewJob
    }
}

# Function to start the job that runs the script
function Start-NewJob {
    Start-Job -Name "DataFetcherJob" -ScriptBlock {
        # Replace this with your actual script path
        & "RemoteCheckMultipleBenchesV2.ps1"
    }
}

# Initialize the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Computer Information"
$form.Width = 400
$form.Height = 300

# Create a ListBox to display data
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Width = 350
$listBox.Height = 200
$listBox.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($listBox)

# Start the job for the first time
Start-NewJob

# Set up a Timer to periodically update the ListBox
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 500 # Check every 5 seconds
$timer.Add_Tick({ Update-ListBox })
$timer.Start()

# Display the form
$form.ShowDialog()

# Clean up jobs after closing the form
Remove-Job -Name "DataFetcherJob" -Force
