function Add-CyberArkUser{
<#
.SYNOPSIS
Function to add a new user account in the CyberArk Vault
.DESCRIPTION
Function to add a new user account in the CyberArk Vault
.EXAMPLE
Add-CyberArkUser -target components.cyber-ark-demo.local -UserName "testuser1" -InitialPassword "Password1" -EMail "testuser1@cyberark.com" -FirstName "test" -LastName "user" -ChangePasswordOnNextLogon $true -ExpiryDate "01/01/2017" -UserTypeName "EPVUser" -Disabled $false
.PARAMETER target
The computer hostname of the PVWA hosting the CyberArk Rest API.
.PARAMETER UserName
Username for the new vault user account
.PARAMETER ExpiryDate (required)
Expiry date for the new account in the format DD/MM/YYYY
#>
[CmdLetBinding()]
    param(
         [parameter(Mandatory=$true)][string]$Target,
         [parameter(Mandatory=$true)][string]$Username,
         [parameter(Mandatory=$true)][string]$InitialPassword,
         [parameter(Mandatory=$true)][string]$EMail,
         [string]$FirstName,
         [string]$LastName,
         [boolean]$ChangePasswordOnNextLogon=$true,
         [ValidatePattern("^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$")][string]$ExpiryDate,
         [parameter(Mandatory=$true)][ValidateSet("EPVUser","AIMAccount","CPM","PVWA","PSM","AppProvider","iSeriesApp","OPMProvider","PSMUser","IBVUser","AutoIBVUser","CIFS","FTP","SFE","DCAUser","DCAInstance","SecureEpClientUser","ClientlessUser","AdHocRecipient","SecureEmailUser","SEG","PSMPADBridge","PSMPServer","AllUsers","CCPEndpoints","PTA")][string]$UserTypeName="EPVUser",
         [boolean]$Disabled,
         [string]$Location

         )

         BEGIN {

        $authtoken = Authenticate-CyberArkUser -Target $Target

        }

        PROCESS {

        $CyberArkUser = New-Object -TypeName PSObject

        $CyberArkUser | Add-Member -MemberType NoteProperty -Name UserName -Value $Username
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name InitialPassword -Value $InitialPassword
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name Email -Value $EMail
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name FirstName -Value $FirstName
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name LastName -Value $LastName
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name ChangePasswordOnTheNextLogon -Value $ChangePasswordOnNextLogon
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name ExpiryDate -Value $ExpiryDate
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name UserTypeName -Value $UserTypeName
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name Disabled -Value $Disabled
        $CyberArkUser | Add-Member -MemberType NoteProperty -Name Location -Value $Location

        $JSON = $CyberArkUser | ConvertTo-Json

        Write-Verbose $JSON

        Invoke-RestMethod -Uri "https://$target/PasswordVault/WebServices/PIMServices.svc/Users" -Body $JSON -Method Post -ContentType "application/json" -Headers @{Authorization=$authtoken}

        }

        END {

        Deauthenticate-CyberArkUser -Target $target -authtoken $authtoken

        }
}
