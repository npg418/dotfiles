$DotDir = Split-Path $MyInvocation.MyCommand.Path
Set-Location $DotDir

foreach ($Item in (Get-ChildItem .\PowerShell))
{
  New-Item "~\Documents\PowerShell\$($Item.Name)" -Force -ItemType SymbolicLink -Value $Item.Fullname 
}

if (Get-Command * | Where-Object { $_.Name -match "nvim" })
{
  New-Item $Env:LocalAppData\nvim -Force -ItemType SymbolicLink -Value (Resolve-Path .\.config\nvim)
}

if (Get-Command * | Where-Object { $_.Name -match "git" })
{
  New-Item ~\.gitconfig -Force -ItemType SymbolicLink -Value $DotDir\.gitconfig | ForEach-Object { $_.Attributes += "Hidden" }
}

if (Get-Command * | Where-Object { $_.Name -match "oh-my-posh" })
{
  New-Item $Env:POSH_THEMES_PATH\npg418.omp.json -Force -ItemType SymbolicLink -Value $DotDir\npg418.omp.json
}
