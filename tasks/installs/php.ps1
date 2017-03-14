Import-Module .\..\..\modules\edi_core.psm1 -Force

Write-EDIHeader "Installing PHP"

choco install php -y

if($?)
{
  Write-EDIHost "Install Succeeded"
}
else
{
  Write-EDIHost "Install Failed"
  Set-EDIExit 1
}


