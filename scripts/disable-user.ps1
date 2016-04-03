# Command line parameters
Param($User=$null,
      [switch]$Confirm=$FALSE,
      [switch]$WhatIf=$FALSE
      )

# Import modules
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin


$Date = Get-Date -Format d
$CurrentUser = [Environment]::UserName
$EmailSuffix = "@intechengineers.com.au"
$DefaultPassword = "passwordgoeshere"
$SecurePassword = ConvertTo-SecureString -String $DefaultPassword -AsPlainText -Force

if ($User -eq $null) {
    Write-Host "An active directory user must be specified"
    Write-Host "Eg disable-user -User user.name"
    Write-Host "The where user.name is the SamAccountName of the user"
    exit
    }

else {
    Set-ADAccountPassword -Identity $User -NewPassword $SecurePassword -Confirm:$Confirm -WhatIf:$WhatIf
    Write-Host "Password for $User set to $DefaultPassword"
    Set-ADUser -Identity $User -Enabled $FALSE -Description "DISABLED $Date" -Confirm:$Confirm -WhatIf:$WhatIf
    Write-Host "Disabled $User account"
    Get-Mailbox -Identity "$User$EmailSuffix" | Add-MailboxPermission -User $CurrentUser -AccessRights FullAccess -Confirm:$Confirm -WhatIf:$WhatIf
    Write-Host "Enabled access to $User$EmailSuffix for $CurrentUser"
    Write-Host "$User disabled"
    }

exit
