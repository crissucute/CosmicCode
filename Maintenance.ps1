$csvContent = Import-Csv -Path $csvFilePath
$maintenanceLines = $csvContent | Where-Object { $_.Message -eq "We are under maintenance mode!" }
$maintenanceLineCount = $maintenanceLines.Count

Write-Host "Lines under maintenance: $maintenanceLineCount"