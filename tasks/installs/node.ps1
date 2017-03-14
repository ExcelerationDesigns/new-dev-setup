Import-Module .\..\..\modules\edi_core.psm1 -Force

Write-EDIHeader "Installing NodeJS"

choco install nodejs -y

if($?)
{
  Write-EDIHost "Install Succeeded"
}
else
{
  Write-EDIHost "Install Failed"
  Set-EDIExit 1
}


