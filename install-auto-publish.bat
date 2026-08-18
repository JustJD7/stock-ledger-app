@echo off
setlocal
set REPO=%~dp0
set TASKNAME=StockLedgerAutoPublish

echo Installing the auto-publish background watcher...

schtasks /Query /TN "%TASKNAME%" >nul 2>&1
if %ERRORLEVEL%==0 (
  echo Removing existing task first...
  schtasks /Delete /TN "%TASKNAME%" /F >nul
)

schtasks /Create /TN "%TASKNAME%" /TR "powershell.exe -NoLogo -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%REPO%watch-and-publish.ps1\"" /SC ONLOGON /RL LIMITED /F
if errorlevel 1 (
  echo Could not create the scheduled task. See the error above.
  pause
  exit /b 1
)

echo Starting it now for this session...
schtasks /Run /TN "%TASKNAME%"

echo.
echo Done. From now on: click "Publish live data" in the dashboard and it goes live
echo on its own within a few seconds — no more running publish.bat by hand.
echo It will also start automatically every time you log in to Windows.
echo.
echo Log file: %REPO%auto-publish.log
echo To remove it later, run uninstall-auto-publish.bat
pause
