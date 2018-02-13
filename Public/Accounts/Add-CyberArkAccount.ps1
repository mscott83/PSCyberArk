function Add-CyberArkAccount {
    <#
  .SYNOPSIS
  Function to add accounts to safes in the CyberArk Vault
  .DESCRIPTION
  Function to add accounts to safes in the CyberArk Vault.
  .EXAMPLE
  Add-CyberArkAccount -target components.cyber-ark-demo.local -safe "Test Safe" -PlatformID "Windows Server Local Accounts" -address "server1.cyber.internal" -username "admintest" -password "Password"
  .PARAMETER Target
  The computer hostname of the PVWA hosting the CyberArk Rest API.
  .PARAMETER Safe
  .PARAMETER PlatformID
  .PARAMETER Address
  .PARAMETER AccountName
  .PARAMETER Password
  .PARAMETER Username
  .PARAMETER DisableAutoMgmt
  .PARAMETER DisableAutoMgmtReason
  .PARAMETER GroupName
  #>
param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken,
        [parameter(Mandatory=$true)][string]$SafeName,
        [parameter(Mandatory=$true)][string]$PlatformID,
        [string]$Address,
        [string]$Port,
        [string]$AccountName,
        [parameter(Mandatory=$true)][string]$Password,
        [parameter(Mandatory=$true)][string]$Username,
        [boolean]$DisableAutoMgmt=$false,
        [string]$DisableAutoMgmtReason,
        [string]$GroupName,
        [string]$GroupPlatformID
        #[alias("LogonAccountName")][string]$ExtraPass1Name,
        #[alias("LogonAccountFolder")][string]$ExtraPass1Folder,
        #[alias("LogonAccountSafe")][string]$ExtraPass1Safe,
        #[alias("ReconcileAccountName")][string]$ExtraPass3Name,
        #[alias("ReconcileAccountFolder")][string]$ExtraPass3Folder,
        #[alias("ReconcileAccountSafe")][string]$ExtraPass3Safe
     )

     PROCESS{

     $Account = New-Object –TypeName PSObject

     $Account | Add-Member –MemberType NoteProperty -Force –Name account –Value @{safe=$SafeName;
                                                                                  platformID=$PlatformID;
                                                                                  address=$Address;
                                                                                  accountName=$AccountName;
                                                                                  password=$Password;
                                                                                  username=$Username;
                                                                                  DisableAutoMgmt=$DisableAutoMgmt;
                                                                                  disableAutoMgmtReason=$DisableAutoMgmtReason;
                                                                                  groupName=$GroupName;
                                                                                  groupPlatformID=$GroupPlatformID
                                                                                  }

     $JSON = $Account | ConvertTo-Json

     Write-Host $JSON

     #Post-CyberArkWebRequest -Target $target -Uri $uri -JSON $JSON

     Invoke-RestMethod -Uri "https://$target/PasswordVault/WebServices/PIMServices.svc/Account" -Body $JSON -Method Post -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken} -ErrorAction Continue

     }

}
