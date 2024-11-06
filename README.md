# RemoveMultipleSourcesMembersFromTargetGroup
PowerShell script to remove members from a target group, sourced from multiple groups. Efficiently manages group memberships in Active Directory, logs actions to a file, and provides real-time feedback. Ideal for IT admins managing complex group structures

## Description
This PowerShell script removes members from a target group, sourced from multiple groups in Active Directory. It efficiently manages group memberships, logs actions to a file, and provides real-time feedback. Ideal for IT administrators managing complex group structures.

## Features
- Removes members from a specified target group.
- Sources members from multiple specified groups.
- Logs all actions to a log file in the current directory.
- Provides real-time feedback on the script's progress.

## Usage
1. **Set the confirmation preference**: The script sets the `$ConfirmPreference` to "None" to avoid confirmation prompts.
2. **Define group names**: Modify the `$groupesSource` array with the names of the source groups and set the `$groupeCible` variable to the target group name.
3. **Run the script**: Execute the script in PowerShell.

### Example
```powershell
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
```
## Logging
The script logs all actions to a file named `LogFile.txt` in the current directory. Each log entry includes a timestamp for easy tracking.

## Real-Time Feedback
The script provides real-time feedback by displaying messages at the start and end of the script execution in green.

## Requirements
- PowerShell
- Active Directory module for PowerShell

## Author

Script written by **David Bouhadana**.

- Blog: [M365 journey](https://m365journey.blog/)

## License

This project is licensed under **GNU GPL 3**. You are free to use, modify, and distribute this code as long as the modifications and derived versions are also licensed under GNU GPL 3. For more information, please refer to the full license text [GNU GPL 3](https://www.gnu.org/licenses/gpl-3.0.html).
