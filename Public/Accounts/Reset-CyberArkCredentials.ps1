function Reset-CyberArkCredentials {
<#
.SYNOPSIS
Function to perform a rotation of credentials stored in the CyberArk Vault
.DESCRIPTION
Function to perform a rotation of credentials stored in the CyberArk Vault
.EXAMPLE
Reset-CyberArkCredentials -target components.cyber-ark-demo.local -AuthenticationToken $authtoken -UserName "testuser1" -InitialPassword "Password1" -EMail "testuser1@cyberark.com" -FirstName "test" -LastName "user" -ChangePasswordOnNextLogon $true -ExpiryDate "01/01/2017" -UserTypeName "EPVUser" -Disabled $false
.PARAMETER target
The computer hostname of the PVWA hosting the CyberArk Rest API.
.PARAMETER AuthenticationToken
Authentication token generated by the Connect-CyberArkUser functon after the user has authenticated to the PVWA.
.PARAMETER AccountID
AccountID of the account to be reset.
.PARAMETER ImmediateChangeByCPM
Whether or not the password should be reset immediately by the CPM
.PARAMETER ChangeCredsForGroup
Whether or not credentials should be changed for the entire Account Group (if applicable)
#>
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken,
        [parameter(Mandatory=$true)][string]$AccountID,
        [string]$ImmediateChangeByCPM="Yes",
        [string]$ChangeCredsForGroup="No"
        )

        Invoke-WebRequest -Uri "https://$target//PasswordVault/WebServices/PIMServices.svc/Accounts/$AccountID/ChangeCredentials" -Method Put -Verbose -Debug -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken;ImmediateChangeByCPM=$ImmediateChangeByCPM;ChangeCredsForGroup=$ChangeCredsForGroup}

}
