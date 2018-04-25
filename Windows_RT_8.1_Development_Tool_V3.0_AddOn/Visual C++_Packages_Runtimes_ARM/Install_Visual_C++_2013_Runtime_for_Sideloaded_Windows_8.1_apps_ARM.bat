if not "%1"=="am_admin" (PowerShell start -verb runas '%0' am_admin & exit)
cd /d %~dp0 > NUL
PowerShell.exe Set-ExecutionPolicy Unrestricted > NUL
PowerShell.exe Add-Appxpackage Visual_C++_2013_Runtime_for_Sideloaded_Windows_8.1_apps_ARM.appx