function Disconnect-CyberArkUser{
    param(
        [parameter(Mandatory=$true)][string]$Target,
        [parameter(Mandatory=$true)][string]$AuthenticationToken
    )

	PROCESS {

	Try
        {
            Invoke-WebRequest -Uri "https://$target/PasswordVault/WebServices/auth/CyberArk/CyberArkAuthenticationService.svc/Logoff" -Method Post -ContentType "application/json" -Headers @{Authorization=$AuthenticationToken}
        }
        Catch
        {
            Write-Error "Error accessing REST API: $($_.Exception.Message)"
        }
	}
}
