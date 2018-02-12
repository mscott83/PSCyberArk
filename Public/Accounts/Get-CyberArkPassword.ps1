function Get-CyberArkPassword {
param(
        [parameter(Mandatory=$true)][string]$Keyword,
        [parameter(Mandatory=$true)][string]$Safe

        )

    $uri = "/PasswordVault/WebServices/PIMServices.svc/Accounts/"
    $method = "GET"

}
