param(
  [string]$IndexPath = (Join-Path $PSScriptRoot "index.html")
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $IndexPath)) {
  throw "index.html not found: $IndexPath"
}

$content = Get-Content -LiteralPath $IndexPath -Raw
$patched = [regex]::Replace(
  $content,
  "(?m)^([ \t]*)-repeat\s+center;",
  "`$1background-repeat:no-repeat;`r`n`$1background-position:center;"
)

if ($patched -ne $content) {
  Set-Content -LiteralPath $IndexPath -Value $patched -NoNewline
  Write-Host "Patched index.html background repeat/position typo."
} else {
  Write-Host "No index.html background typo found."
}
