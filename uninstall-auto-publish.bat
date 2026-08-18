@echo off
setlocal
set TASKNAME=StockLedgerAutoPublish

schtasks /Query /TN "%TASKNAME%" >nul 2>&1
if errorlevel 1 (
  echo No auto-publish watcher is installed.
  pause
  exit /b 0
)

schtasks /Delete /TN "%TASKNAME%" /F
echo.
echo Auto-publish watcher removed. Publishing is back to the manual flow:
echo click "Publish live data", then double-click publish.bat.
pause
