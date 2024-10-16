# Set the confirmation preference
$ConfirmPreference = "None"

# Define the names of the source and target groups
$groupesSource = @("GroupeSourceA", "GroupeSourceB", "GroupeSourceC")
$groupeCible = "GroupeCible"

# Log file in the current directory
$logFile = ".\LogFile.txt"

# Function to write to the log
function Write-Log {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Add-Content -Path $logFile -Value $logMessage
}

# Start of the script
Write-Host "Script started" -ForegroundColor Green

# Get the list of members from each source group and remove them from the target group
foreach ($groupeSource in $groupesSource) {
    $membresGroupeSource = Get-ADGroupMember -Identity $groupeSource
    foreach ($membre in $membresGroupeSource) {
        Remove-ADGroupMember -Identity $groupeCible -Members $membre -Confirm:$false
        Write-Log "Member $($membre.SamAccountName) removed from group $groupeCible"
    }
    Write-Log "All members of group $groupeSource have been processed"
}

# End of the script
Write-Log "Script completed"
Write-Host "Script completed" -ForegroundColor Green
