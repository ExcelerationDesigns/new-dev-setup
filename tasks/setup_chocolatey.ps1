Import-Module ..\modules\edi_core.psm1 -Force

Write-EDIHeader "Install Chocolatey"

Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

if($?)
{
  Write-EDIHost "Install Succeeded"
}
else
{
  Write-EDIHost "Install Failed"
  Set-EDIExit 1
}
