@echo off
setlocal

set REPO=%~dp0
set DL=%USERPROFILE%\Downloads\data.json

if not exist "%DL%" (
  echo Could not find %DL%
  echo Click "Publish live data" in the dashboard first, then run this again.
  pause
  exit /b 1
)

copy /Y "%DL%" "%REPO%data.json" >nul
del "%DL%"

cd /d "%REPO%"
git add data.json
git commit -m "Publish data snapshot"
git push

echo.
echo Done. Live at https://justjd7.github.io/stock-ledger-app/
pause
