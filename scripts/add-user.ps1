<# Input paramaters #>
Param($User=$null,
      $Office="BNE",
      [switch]$RemoteUser=$FALSE,
      [switch]$Confirm=$FALSE,
      [switch]$WhatIf=$FALSE,
      [switch]$NoMail=$FALSE
      )
<# Import Modules #>
# Import modules
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

$Year = Get-Date -Format yyyy
$DefaultPassword = ConvertTo-SecureString -String "Welcome$Year" -AsPlainText -Force
$Domain = "@intech.local"
$PossibleOU = "BNE","PRT","TVL"
$LoginScript = "SBS_LOGIN_SCRIPT.bat"
$DefaultGroups = "Intech","Users"
$RemoteGroups = "Web Workplace Users","IntechVPN","VPN Users"
$ExchangeDatabase = "w2k8ms1\First Storage Group\Mailbox Database"
$ADStandardOU = "OU=Users,OU=MyBusiness,DC=intech,DC=local"

# Check input paramaters
if (-Not $PossibleOU.Contains($Office)) {
    Write-Host "-Office must be one of: $PossibleOU"
    exit
    }

if (-Not $User.Contains('.')) {
    Write-Host "-User must separate the first and last name witha period (.)"
    exit
    }

# Determine first, last and fullname based on username paramater
$FirstName = $User.Split('.')[0]
$LastName = $User.Split('.')[1]
$FullName = "$FirstName $LastName"

# Create the user and add them to groups
Write-Host "Creating new user $User"
New-ADUser -Name $User -SamAccountName $User -UserPrincipalName $User$Domain -AccountPassword $DefaultPassword -ChangePasswordAtLogon $TRUE -GivenName $FirstName -Surname $LastName -DisplayName $FullName -Path "OU=$Office,$ADStandardOU" -ScriptPath $LoginScript -Enabled $TRUE
# Only the Brisbane office has a distribution group
if ($Office -eq "BNE") {
    Write-Host "Adding $User to BNE distribution group"
    Add-ADGroupMember -Identity $Office -Members $User
    }

ForEach ($Group in $DefaultGroups) {
    Write-Host "Adding $User to $Group"
    Add-ADGroupMember -Identity $Group -Members $User
    }

# If user is nominated as a remote user add them to the additional required groups
if ($RemoteUser) {
    ForEach ($Group in $RemoteGroups) {
        Write-Host "Adding $User to $Group"
        Add-ADGroupMember -Identity $Group -Members $User
        }
    }


# Create the exchange mailbox
if (-Not ($NoMail)) {
    Write-Host "Sleeping for 30 seconds to allow AD User creation"
    Start-Sleep -s 30
    Write-Host "Creating mailbox for $User"
    Enable-Mailbox -Identity $User -Database $ExchangeDatabase
    Write-Host "$User added"
    }
exit