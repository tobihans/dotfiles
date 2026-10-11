# CurrentUserAllHosts profile for PowerShell 7 ($HOME\Documents\PowerShell\profile.ps1).
# Windows PowerShell 5.1 reads Documents\WindowsPowerShell\profile.ps1 instead.

$env:EDITOR = 'nvim'

# gsudo ships a PowerShell module for elevation from a non-elevated shell.
if (Get-Module -ListAvailable -Name gsudoModule) {
    Import-Module gsudoModule
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

. (Join-Path $PSScriptRoot 'aliases.ps1')
