$notepadProcessName = "notepad.exe"
$maintenanceFilePath = "C:\temp\maintenance.txt"
$csvFilePath = "C:\temp\notepad_monitoring.csv"
$sampleDurationInSeconds = 300
$sampleIntervalInSeconds = 5

# Function to start Notepad and write to CSV
function Start-NotepadAndWriteCSV {
    Start-Process -FilePath $notepadProcessName
    $currentTime = Get-Date -Format "dd-MM-yyyy HH:mm"
    $message = "Notepad was started"
    Write-CSVEntry $currentTime $message
}

# Function to write to CSV
function Write-CSVEntry {
    param(
        [string]$time,
        [string]$message
    )
    $entry = [PSCustomObject]@{
        Date = $time
        Message = $message
    }
    $entry | Export-Csv -Path $csvFilePath -Append -NoTypeInformation
}

# Function to check if maintenance is active
function IsMaintenanceActive {
    return Test-Path $maintenanceFilePath
}

# Main script logic
$endTime = (Get-Date).AddSeconds($sampleDurationInSeconds)
while ((Get-Date) -lt $endTime) {
    if (Test-Path $maintenanceFilePath) {
        Write-CSVEntry (Get-Date -Format "dd-MM-yyyy HH:mm") "We are under maintenance mode!"
    } else {
        $notepadProcess = Get-Process -Name $notepadProcessName -ErrorAction SilentlyContinue
        if ($notepadProcess) {
            Write-CSVEntry (Get-Date -Format "dd-MM-yyyy HH:mm") "Notepad is running"
        } else {
            Start-NotepadAndWriteCSV
        }
    }
    Start-Sleep -Seconds $sampleIntervalInSeconds
}
