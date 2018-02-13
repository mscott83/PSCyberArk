function Search-CyberArkSafe{
<#
.SYNOPSIS
Function to search for safes in the CyberArk Vault
.DESCRIPTION
Function to search for safes in the CyberArk Vault.
.EXAMPLE
Search-CyberArkSafe -target components.cyber-ark-demo.local -AuthenticationToken $authtoken -Query "Test Safe"
.PARAMETER Target
The computer hostname of the PVWA hosting the CyberArk Rest API.
.PARAMETER AuthenticationToken
Authentication token received from the Connect-CyberArkUser CmdLet after the user has authenticated.
.PARAMETER Query
Search query.
#>
  param([parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken,
        [parameter(Mandatory=$true)][string]$Query
)

        $result = Invoke-RestMethod -Uri "https://$target/PasswordVault/WebServices/PIMServices.svc/Safes?query=$Query" -Method Get -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken}

        $return = $result.SearchSafesResult

        Write-Output $return
}
