# Dot sourcing public function files
Write-Verbose "$((get-location).path)\public"
Get-ChildItem -path  "$((get-location).path)\public" -Recurse -Filter "*.ps1" -File | Foreach {
    write-verbose $_.FullName
    . $_.FullName

    # Find all the functions defined no deeper than the first level deep and export it.
    # This looks ugly but allows us to not keep any uneeded variables from poluting the module.
    ([System.Management.Automation.Language.Parser]::ParseInput((Get-Content -Path $_.FullName -Raw), [ref]$null, [ref]$null)).FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false) | Foreach {
        Export-ModuleMember $_.Name
    }
}

#"$((get-location).path)\public"
