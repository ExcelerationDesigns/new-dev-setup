Import-Module .\modules\edi_core -Force

.\features\iis.ps1

<#
.\tasks\setup_chocolatey.ps1

.\tasks\installs\git.ps1
.\tasks\installs\node.ps1
.\tasks\installs\vscode.ps1
.\tasks\installs\github.ps1
.\tasks\installs\php.ps1
.\tasks\installs\sql_express.ps1

#>

Set-Location C:\
Get-ChildItem
