$DotDir = Split-Path $MyInvocation.MyCommand.Path
Set-Location $DotDir

foreach ($Item in (Get-ChildItem .\PowerShell))
{
  New-Item "~\Documents\PowerShell\$($Item.Name)" -Force -ItemType SymbolicLink -Value $Item.Fullname 
}

if (Get-Command * | Where-Object { $_.Name -match "nvim" }) {
  New-Item $Env:LocalAppData\nvim -Force -ItemType SymbolicLink -Value (Resolve-Path .\.config\nvim)
}
