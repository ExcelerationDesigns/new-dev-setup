Import-Module ..\modules\edi_core.psm1 -Force

Write-EDIHeader "Install IIS"

$features = ".\features\win_2016.txt"

Enable-OSFeatures "Check/install common features" $features
