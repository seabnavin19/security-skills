# Install the security-audit skill for Codex, Cursor, and GitHub Copilot.
# Usage: install.ps1 [skills-dir]   (default: ~/.agents/skills)
param([string]$Dest = (Join-Path $HOME '.agents/skills'))
$ErrorActionPreference = 'Stop'

$Repo = if ($env:REPO) { $env:REPO } else { 'seabnavin19/security-skills' }
$Ref = if ($env:REF) { $env:REF } else { 'main' }

$tmp = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid())
New-Item -ItemType Directory -Path $tmp | Out-Null
try {
    $zip = Join-Path $tmp 'repo.zip'
    Invoke-WebRequest "https://github.com/$Repo/archive/refs/heads/$Ref.zip" -OutFile $zip -UseBasicParsing
    Expand-Archive $zip -DestinationPath $tmp
    $src = Get-ChildItem $tmp -Directory | ForEach-Object { Join-Path $_.FullName 'skills/security-audit' } | Where-Object { Test-Path $_ } | Select-Object -First 1

    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    $target = Join-Path $Dest 'security-audit'
    if (Test-Path $target) { Remove-Item -Recurse -Force $target }
    Copy-Item -Recurse $src $target

    Write-Host "Installed security-audit to $target"
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Host 'Note: full audits run Node.js validators; install Node to use them.'
    }
} finally {
    Remove-Item -Recurse -Force $tmp
}
