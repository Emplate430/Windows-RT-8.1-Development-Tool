@echo off
if not "%1"=="am_admin" (PowerShell start -verb runas '%0' am_admin & exit)
sc stop meow > NUL
sc delete meow > NUL
taskkill /f /im meow_client.exe > NUL
taskkill /f /im powershell.exe > NUL