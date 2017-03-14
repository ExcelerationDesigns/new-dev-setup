Import-Module .\..\..\modules\edi_core.ps1 -Force

Write-EDIHeader "Installing VSCode"

choco install visualstudiocode -y

if($?)
{
  Write-EDIHost "Install Succeeded"
}
else
{
  Write-EDIHost "Install Failed"
  Set-EDIExit 1
}
