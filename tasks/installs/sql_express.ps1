Import-Module .\..\..\modules\edi_core.psm1 -Force

Write-EDIHeader "Installing SQL Server Express 2014"

choco install mssql2014express-defaultinstance -y

if($?)
{
  Write-EDIHost "Install Succeeded"
}
else
{
  Write-EDIHost "Install Failed"
  Set-EDIExit 1
}
