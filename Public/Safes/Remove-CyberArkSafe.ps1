function Remove-CyberArkSafe{
    <#
  .SYNOPSIS
  Function to delete safes in the CyberArk Vault
  .DESCRIPTION
  Function to delete safes in the CyberArk Vault.
  .EXAMPLE
  Remove-CyberArkSafe -target components.cyber-ark-demo.local -SafeName "Test Safe" -AuthenticationToken $authtoken
  .EXAMPLE
  Import-Csv .\Safes.csv | Remove-CyberArkSafe -Target components.cyber.internal -AuthenticationToken $authtoken
  (Sample CSV file available on request)
  .PARAMETER target
  The computer hostname of the PVWA hosting the CyberArk Rest API.
  .PARAMETER SafeName
  The name of the new safe to be created. Maximum length 28 characters
  #>
[CmdletBinding()]
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken,
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][ValidateLength(1,28)][string]$SafeName
        )

        PROCESS{

                Invoke-RestMethod -Uri "https://$target/PasswordVault/WebServices/PIMServices.svc/Safes/$SafeName" -Body $JSON -Method Delete -Verbose -Debug -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken}

        }

}
