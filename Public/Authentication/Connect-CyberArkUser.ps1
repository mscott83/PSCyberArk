function Connect-CyberArkUser{
<#
.SYNOPSIS
Authenticates users to the CyberArk Vault
.DESCRIPTION
Authenticates users to the CyberArk Vault
.EXAMPLE
Connect-CyberArkUser -target components.cyber-ark-demo.local
.PARAMETER Target
The computer hostname of the PVWA hosting the CyberArk REST API.
#>
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][System.Management.Automation.CredentialAttribute()]$Credential
        )

        $credentials = New-Object -TypeName PSObject

        $credentials | Add-Member -MemberType NoteProperty -Name username -Value $Credential.UserName
        $credentials | Add-Member -MemberType NoteProperty -Name password -Value $Credential.GetNetworkCredential().Password

        $JSON = $credentials | ConvertTo-Json

        $token = Invoke-WebRequest -Uri "https://$target/PasswordVault/WebServices/auth/CyberArk/CyberArkAuthenticationService.svc/Logon" -Body $JSON -Method Post -Verbose -Debug -ContentType "application/json"

        $token = ConvertFrom-Json $token

        $AuthenticationToken = $token.CyberArkLogonResult

        write-verbose $AuthenticationToken

        return $AuthenticationToken
}
