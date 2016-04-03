<# Input paramaters #>
Param($PSTFolderPath=$null,
      [int]$DaysDisabled=28,
      [switch]$Confirm=$FALSE,
      [switch]$WhatIf=$FALSE)

# Add exchange snapin
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

$Date = Get-Date
$CurrentUser = [Environment]::UserName

# Query AD for users with a description beginning with 'DISABLED' which is set by disable-user script
$Users = Get-ADUser -filter {Description -like "DISABLED*"} -Properties Description

ForEach ($User in $Users) {
    $DisabledDate = Get-Date($User.Description.Split()[1])
    $Diff = $Date - $DisabledDate
    if ($Diff.Days -ge $DaysDisabled) {
        # User has been disabled for required period
        # If PstFolderPath has been defined export the mailbox
        $SamAccountName = $User.SamAccountName
        Write-Host "Account $SamAccountName has been disabled for at least $DaysDisabled days this account will be purged"
        if ($PSTFolderPath -ne $null) {
            Get-Mailbox -Identity $User.SamAccountName | Add-MailboxPermission -User $CurrentUser -AccessRights FullAccess -Confirm:$Confirm -WhatIf:$WhatIf
            Export-Mailbox -Identity $User.SamAccountName -PSTFolderPath "$PSTFolderPath" -Confirm:$Confirm -WhatIf:$WhatIf
            Write-Host "Mailbox of $SamAccountName exported to $PSTFolderPath"
        }
        # Delete the user
        Remove-ADUser -Identity $User -Confirm:$Confirm -WhatIf:$WhatIf
        Write-Host "$SamAccountName deleted"
        }
    }
exit

    





