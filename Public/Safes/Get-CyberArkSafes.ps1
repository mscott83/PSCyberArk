function Get-CyberArkSafes{
<#
.SYNOPSIS
Function to list safes available to the user in the CyberArk Vault
.DESCRIPTION
Function to list safes available to the user in the CyberArk Vault.
.EXAMPLE
Get-CyberArkSafes -target components.cyber-ark-demo.local
.PARAMETER Target
The computer hostname of the PVWA hosting the CyberArk Rest API.
.PARAMETER AuthenticationCode
Authentication token of a CyberArk user
#>
  [CmdLetBinding()]
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken
    )

        PROCESS{

        $result = Invoke-RestMethod -Uri "https://$target/PasswordVault/WebServices/PIMServices.svc/Safes" -Method Get -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken}

        $safes = ($result.GetSafesResult)

        #Write-Host $safes
        return $safes

        }

}
