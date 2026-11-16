@echo off
rem Removes Conure from this PC. You'll be asked whether to keep a backup of your data.
rem Same as Windows Settings > Apps > Conure > Uninstall, or Conure's Settings > Uninstall.
if exist "%USERPROFILE%\Conure\venv\Scripts\pythonw.exe" (
  start "" "%USERPROFILE%\Conure\venv\Scripts\pythonw.exe" "%USERPROFILE%\Conure\app\dictate.py" --uninstall
) else (
  echo Conure isn't installed in %USERPROFILE%\Conure, so there's nothing to remove.
  pause
)
