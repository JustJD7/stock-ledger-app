# Runs in the background (installed via install-auto-publish.bat) and watches this folder for
# changes to data.json. Whenever the dashboard's "Publish live data" button writes a new
# data.json here, this pushes it to GitHub automatically — no double-clicking publish.bat needed.

$ErrorActionPreference = 'Continue'
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$logFile = Join-Path $repo 'auto-publish.log'

function Write-Log([string]$msg) {
  $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $msg"
  Add-Content -Path $logFile -Value $line
}

function Publish-Snapshot {
  Set-Location $repo
  git add -- data.json | Out-Null
  git commit -m "Publish data snapshot" 2>$null | Out-String | ForEach-Object { if ($_.Trim()) { Write-Log $_.Trim() } }
  if ($LASTEXITCODE -ne 0) {
    Write-Log 'Nothing new to commit (data.json unchanged since last publish).'
    return
  }
  $pushOutput = git push 2>&1 | Out-String
  if ($pushOutput.Trim()) { Write-Log $pushOutput.Trim() }
  if ($LASTEXITCODE -eq 0) { Write-Log 'Published live successfully.' }
  else { Write-Log 'git push FAILED — check network/credentials and push manually if needed.' }
}

Write-Log "Watcher started, watching $repo for data.json changes."

$fsw = New-Object System.IO.FileSystemWatcher
$fsw.Path = $repo
$fsw.Filter = 'data.json'
$fsw.NotifyFilter = [System.IO.NotifyFilters]'LastWrite, Size'

while ($true) {
  $result = $fsw.WaitForChanged([System.IO.WatcherChangeTypes]::Changed, 3600000)
  if ($result.TimedOut) { continue }
  # Debounce: wait for the write to fully settle (createWritable/close can fire more than one event).
  Start-Sleep -Seconds 3
  try { Publish-Snapshot } catch { Write-Log "ERROR: $_" }
}
