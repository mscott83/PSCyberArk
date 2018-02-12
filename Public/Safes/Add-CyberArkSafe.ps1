function Add-CyberArkSafe{
<#
.SYNOPSIS
Function to create safes in the CyberArk Vault
.DESCRIPTION
Function to create safes in the CyberArk Vault.
.EXAMPLE
Add-CyberArkSafe -target components.cyber-ark-demo.local -AuthenticationToken abc123 -SafeName "Test Safe" -Description "Safe for test accounts" -OLACEnabled $false
.EXAMPLE
Import-Csv .\Safes.csv | Add-CyberArkSafe -Target components.cyber.internal -AuthenticationToken abc123
(Sample CSV file available on request)
.PARAMETER target
The computer hostname of the PVWA hosting the CyberArk Rest API.
.PARAMETER SafeName
The name of the new safe to be created. Maximum length 28 characters.
.PARAMETER OLACEnabled
Whether or not the safe should be an Object Level Access Control (OLAC) safe
#>
[CmdletBinding()]
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken,
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][ValidateLength(1,28)][string]$SafeName,
        [parameter(ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][string]$Description,
        [parameter(ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][ValidateSet("TRUE","FALSE")][string]$OLACEnabled="FALSE",
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][string]$ManagingCPM,
        [parameter(ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][ValidateRange(0,999)][int]$NumberOfVersionsRetention,
        [parameter(ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)][ValidateRange(1,3650)][int]$NumberOfDaysRetention=7
        )

      PROCESS{
      # Add safes to the Vault

      if ($OLACEnabled = "TRUE") {$NewOLACEnabled = $true} else {$NewOLACEnabled = $false}

      $Safe = New-Object -TypeName PSObject

      if ($NumberOfVersionsRetention) {

      $Safe | Add-Member -MemberType NoteProperty -Force -Name safe -Value @{SafeName=$SafeName;
                                                                             Description=$Description;
                                                                             OLACEnabled=$NewOLACEnabled;
                                                                             ManagingCPM=$ManagingCPM;
                                                                             NumberOfVersionsRetention=$NumberOfVersionsRetention
                                                                            }
      }

      else {

      $Safe | Add-Member -MemberType NoteProperty -Force -Name safe -Value @{SafeName=$SafeName;
                                                                               Description=$Description;
                                                                               OLACEnabled=$NewOLACEnabled;
                                                                               ManagingCPM=$ManagingCPM;
                                                                               NumberOfDaysRetention=$NumberOfDaysRetention
                                                                              }

      }

      $JSON = $Safe | ConvertTo-Json

      Write-Verbose $JSON

      Invoke-RestMethod -Uri "https://$target/PasswordVault/WebServices/PIMServices.svc/Safes" -Body $JSON -Method Post -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken} -ErrorAction Continue

    }
  }
