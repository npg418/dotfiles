[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Set-Alias ral Remove-Alias
Set-Alias code code-insiders
Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive
Set-Alias v nvim
Set-Alias grep findstr

oh-my-posh init pwsh --config https://raw.githubusercontent.com/craftzdog/dotfiles-public/master/.config/powershell/takuya.omp.json | Invoke-Expression

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
