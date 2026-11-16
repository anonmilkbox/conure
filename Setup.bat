@echo off
rem Double-click to install Conure. It runs setup.ps1 from this folder.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
pause
