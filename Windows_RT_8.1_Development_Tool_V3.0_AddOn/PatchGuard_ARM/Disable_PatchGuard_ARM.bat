@echo off
if not "%1"=="am_admin" (PowerShell start -verb runas '%0' am_admin & exit)
cd %~dp0 > NUL
del C:\Windows\meow.log > NUL
start powershell -Command "& {Get-content C:\Windows\meow.log -wait | where { $_ -cmatch 'INF|WRN|ERR' }}" > NUL
sc create meow type= kernel binPath= "%~dp0meow.sys" > NUL
sc start meow > NUL
start meow_client disarm exit > NUL