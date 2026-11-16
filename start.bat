@echo off
rem Runs Conure from this folder with a console window, so you can watch the log while testing changes.
title Conure
"%USERPROFILE%\Conure\venv\Scripts\python.exe" "%~dp0dictate.py"
pause
