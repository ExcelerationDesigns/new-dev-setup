Import-Module .\..\..\modules\edi_core.psm1 -Force

Write-EDIHeader "Installing Git"

choco install git -y

if($?)
{
  Write-EDIHost "Install Succeeded"
  Write-EDIHost "Refresh Environment"
  refreshenv
}
else
{
  Write-EDIHost "Install Failed"
  Set-EDIExit 1
}


