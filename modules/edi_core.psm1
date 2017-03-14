#region Write-EDIHost
<#
.Synopsis
   Writes message to console, prepends computer name of the console it's writing on.
.DESCRIPTION
   replaces write-host for most console messages
#>
function Write-EDIHost() {
  [CmdletBinding()]
  param($object, $backgroundColor, $ForegroundColor, [switch]$NoNewLine, $separator)
  Begin {
  }
  Process {
    Write-Host "($((Get-Date).ToString())) [$env:computername] " -NoNewline -ForegroundColor Yellow
    Write-Host @PSBoundParameters
  }
  End {
  }
}
#endregion

#region Write-EDIHeader
<#
.Synopsis
   Writes header to console, makes it a header message
.DESCRIPTION
   replaces write-host for most console messages
#>
function Write-EDIHeader() {
  [CmdletBinding()]
  param([string]$title)
  Begin {
  }
  Process {

    Write-EDIHost ""
    Write-EDIHost "========  " -ForegroundColor DarkGreen -NoNewline
    Write-Host $title -ForegroundColor Green -NoNewline
    Write-Host " ========  "
    Write-EDIHost ""
  }
  End {
  }
}
#endregion


#region Write-EDIHeader
<#
.Synopsis
   Writes header to console, makes it a header message
.DESCRIPTION
   replaces write-host for most console messages
#>
function Set-EDIExit() {
  [CmdletBinding()]
  param([int]$title)
  Begin {
  }
  Process {

    Write-EDIHost "Set Exit"
    Exit $title
  }
  End {
  }
}
#endregion

#region Enable-OSFeatures
function Enable-OSFeatures()
{
  [CmdletBinding()]
  param([string]$title, [string]$featuresFileName)

    Begin
    {
    }
    Process
    {
        Write-EDIHost $title
        if (!(Test-Path $featuresFileName))
        {
            Write-EDIHost "Cannot find features file: $featuresFilename" -ForegroundColor Red
            return $false
        }

        Import-Module ServerManager
        $OSFeatures = Get-WindowsFeature
        $featureExpr = '$f.Installed'
        $nameExpr = '$f.name'

        $featListToInstall = @(gc $featuresFileName)
        $featList = @()
        foreach($f in $OSFeatures)
        {
            $featureName = invoke-expression -command $nameExpr
            if ($featListToInstall.Contains($featureName))
            {
                if (!(invoke-expression -command $featureExpr))
                {
                 $featList += $f
                 Write-EDIHost "[Not Installed] " -ForegroundColor Red -NoNewline
                }
                else
                {
                    Write-EDIHost "[Installed] " -ForegroundColor Green -NoNewline
                }
                Write-Host ($featureName)
            }
        }
        foreach($nf in $featListToInstall)
        {
            if ($nf.ToString().StartsWith("#"))
            {
             continue
            }
            $found = $false
            foreach($f in $OSFeatures)
            {
               $featureName = invoke-expression -command $nameExpr
             if ($featureName.Equals($nf))
             {
               $found = $true;
               break
             }
            }
            if (!$found -and $nf.ToString().Trim().Length -gt 0)
            {
              Write-EDIHost "Check Spelling/Casing for: $nf"
            }

        }
        #todo: list features listed in $featuersFileName that don't match any installed feature
        if ($featList.Length -gt 0)
        {
          Write-EDIHost "Installing missing features, Count: $($featList.Length)"
          $needRestart = $false
          if ($OSType -eq "Win7")
          {
            $featList | ForEach-Object {Add-ClientFeature -Name $_.Name;}
          }
          elseif ($OSType -in "Win8","Win10")
          {
            $featList | ForEach-Object {$res = Enable-WindowsOptionalFeature -online -FeatureName $_.FeatureName -all -NoRestart; $needRestart = $needRestart -or $res.RestartNeeded;}
          }
          else
          {
            $res = Add-WindowsFeature $featList
            $needRestart =  $res.RestartNeeded
          }

           if ($?)
           {
             Write-EDIHost "Installed missing features successfully" -ForegroundColor Green
             if ($needRestart){
             Write-EDIHost "********  Restart needed!  ********" -ForegroundColor Yellow
             }
           }
           else
           {
            Write-EDIHost "Encountered error while installing features" -ForegroundColor Red
            throw
           }
        }
    }
    End
    {
    }
}
#endregion
