[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Set-Alias ral Remove-Alias
Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive
Set-Alias v nvim
Set-Alias g git
Set-Alias grep findstr

if (Test-Path alias:ls) {
  Remove-Alias ls -Force
}
function ls {
  Invoke-Expression "eza --icons --git $args"
}
function ll {
  Invoke-Expression "ls --long --header --group $args"
}
function la {
  Invoke-Expression "ll --all $args"
}

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\npg418.omp.json" | Invoke-Expression
Import-Module posh-git
$env:POSH_GIT_ENABLED = $true

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi -BellStyle Visual -PredictionSource HistoryAndPlugin

Import-Module Terminal-Icons

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Import-Module ZLocation

function Set-LocationToGitRoot {
  $GitRoot = git rev-parse --show-toplevel
  Set-Location $GitRoot
}
Set-Alias cdgr Set-LocationToGitRoot

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Import-Module PoShFuck
Get-ChildItem "$PROFILE\..\Completions\" | ForEach-Object {
    . $_.FullName
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

