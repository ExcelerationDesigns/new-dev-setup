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
    Write-Host "========  "
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
