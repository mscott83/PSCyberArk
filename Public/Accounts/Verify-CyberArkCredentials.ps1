function Verify-CyberArkCredentials {
<#
.SYNOPSIS
Function to perform a verify of credentials stored in the CyberArk Vault
.DESCRIPTION
Function to perform a verify of credentials stored in the CyberArk Vault
.EXAMPLE
Verify-CyberArkCredentials -target components.cyber-ark-demo.local -AuthenticationToken $authtoken -AccountID 48_3
.PARAMETER target
The computer hostname of the PVWA hosting the CyberArk Rest API.
.PARAMETER AuthenticationToken
Authentication token generated by the Connect-CyberArkUser functon after the user has authenticated to the PVWA.
.PARAMETER AccountID
AccountID of the account to be reset.
#>
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken,
        [parameter(Mandatory=$true)][string]$AccountID
        )

        Invoke-WebRequest -Uri "https://$target//PasswordVault/WebServices/PIMServices.svc/Accounts/$AccountID/Verify" -Method Post -Verbose -Debug -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken}
}
