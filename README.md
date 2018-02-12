# PSCyberArk

## Installation

1. Clone this repository to your user profile:

git clone https://github.com/mscott83/PSCyberArk %USERPROFILE%\Documents\Modules

ALTERNATIVELY to deploy PSCyberArk for every user on the machine

git clone https://github.com/mscott83/PSCyberArk %PROGRAMFILES%\WindowsPowerShell\Modules

2. Import the module into PowerShell. Open a PowerShell prompt and run:

Import-Module PSCyberArk

If you are cloning a new version, you may need to run the following to forcibly reload the module:

Import-Module PSCyberArk -Force

## CmdLets

### Authentication
*Connect-CyberArkUser
*Disconnect-CyberArkUser

### Safe Operations
*Add-CyberArkSafe
*Remove-CyberArkSafe
*Get-CyberArkSafe
*Search-CyberArkSafe

### Account Operations
*Add-CyberArkAccount
*Edit-CyberArkAccount
*Remove-CyberArkAccount
