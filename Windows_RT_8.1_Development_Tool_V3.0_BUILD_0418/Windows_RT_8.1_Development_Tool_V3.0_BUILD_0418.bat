@echo off
title [Windows RT 8.1] Development Tool Version 3.0 BUILD 0418
if not "%1"=="am_admin" (PowerShell start -verb runas '%0' am_admin & exit)
goto home

:home
color 1F
cls
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                        WRITTEN BY QIANGONG2 AND VNNGYN                       -
echo -                              RELEASED 30/01/2016                             -        
echo --------------------------------------------------------------------------------
echo -           This tool is meant for Windows RT 8.1 users to run signed          -
echo -    ARM-compiled applications in the desktop environment of Windows RT 8.1.   -
echo -                    This tool is provided without warranty.                   -
echo -                Any damage caused, is your own responsibility.                -
echo --------------------------------------------------------------------------------
echo -     If you understand and accept the above. Press any key to continue...     -
echo --------------------------------------------------------------------------------
echo -                  COPYRIGHT 2017 VNNGYN. All rights reserved.                 -
echo --------------------------------------------------------------------------------
pause > NUL
goto elevationcheck

:elevationcheck
color 1C
cls
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                  ADMIN CHECK                                 -
echo --------------------------------------------------------------------------------
echo -                    Checking for administrator elevation...                   -                 
echo --------------------------------------------------------------------------------
echo.
echo.
openfiles > NUL 2>&1
if %errorlevel%==0 (
	echo Administrator elevation found! Proceeding...
	goto mainmenu
) else (
    echo --------------------------------------------------------------------------------
	echo -                    You are not running as administrator...                   -
	echo -                This tool cannot do its job without elevation!                -
	echo --------------------------------------------------------------------------------
	echo.
	echo --------------------------------------------------------------------------------
	echo -                           Press any key to exit...                           -
	echo --------------------------------------------------------------------------------
	pause > NUL
	exit
)

:mainmenu
color 1F
cls
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                   MAIN MENU                                  -
echo --------------------------------------------------------------------------------
echo -          Make sure your system is up-to-date before doing anything!          -
echo ---------------------------------------------------------------------------------
echo - 1^) Modify Windows Update                                                     -                          
echo - 2^) Remove Infected Updates                                                   -
echo - 3^) Boot Into Test Mode                                                       -  
echo - 4^) Boot Into Normal Mode                                                     - 
echo - 5^) Exit                                                                      -          
echo --------------------------------------------------------------------------------
echo.
set /p mmchoice= - Selection: 
if %mmchoice%==1 goto modifywindowsupdate
if %mmchoice%==2 goto removeinfectedupdates
if %mmchoice%==3 goto testmode
if %mmchoice%==4 goto normalmode
if %mmchoice%==5 exit
goto error

:error
color 1C
cls
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                     ERROR                                    -
echo --------------------------------------------------------------------------------
echo -                       You did not enter a valid entry.                       -
echo --------------------------------------------------------------------------------
echo -            Press any key to return to the main menu and try again.           -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:modifywindowsupdate
cls
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                WINDOWS UPDATE                                -
echo --------------------------------------------------------------------------------
echo - Recommended choice: 1                                                        -
echo --------------------------------------------------------------------------------
echo - 1^) Block Windows Update.                                                     -                                            
echo - 2^) Let Windows Update notify you before downloading updates.                 -   
echo - 3^) Let Windows Update automatically download updates and notify you when     - 
echo -    it is ready for installation.                                             -               
echo - 4^) Let Windows Update automatically install updates.                         -                
echo --------------------------------------------------------------------------------
echo.
set /p mmchoice=- Selection: 
if %mmchoice%==1 goto windowsupdate1
if %mmchoice%==2 goto windowsupdate2
if %mmchoice%==3 goto windowsupdate3
if %mmchoice%==4 goto windowsupdate4
goto error

:windowsupdate1
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 0 /f > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                WINDOWS UPDATE                                -
echo --------------------------------------------------------------------------------
echo -                 Windows Update has succesfully been blocked.                 -
echo --------------------------------------------------------------------------------
echo -                   Press any key to return to the main menu.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:windowsupdate2
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 2 /f > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                WINDOWS UPDATE                                -
echo --------------------------------------------------------------------------------
echo -          Windows Update will notify you before downloading updates.          -
echo --------------------------------------------------------------------------------
echo -                   Press any key to return to the main menu.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:windowsupdate3
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                WINDOWS UPDATE                                -
echo --------------------------------------------------------------------------------
echo -            Windows Update will automatically download updates and            -
echo -                 notify you when it's ready for installation.                 -
echo --------------------------------------------------------------------------------
echo -                   Press any key to return to the main menu.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:windowsupdate4
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 5 /f > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                WINDOWS UPDATE                                -
echo --------------------------------------------------------------------------------
echo -              Windows Update will automatically install updates.              -
echo --------------------------------------------------------------------------------
echo -                   Press any key to return to the main menu.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:removeinfectedupdates
cls
cd /d %~dp0 > NUL
PowerShell.exe Set-ExecutionPolicy Unrestricted > NUL
start PowerShell.exe ./WindowsUpdate.UninstallUpdates.ps1 4019215, 4019217, 4022726, 4022720, 4015550, 4015553, 3205401, 3084905, 3088195, 3108381, 3115224, 3126593, 3128650, 3146723, 3153171, 3170377, 3172614, 3172727, 3175024, 3179574, 4012216, 4012219, 3197874, 3197875, 3185331, 3192404, 3101746, 3121212, 3156418, 3161606, 4025335, 4025336, 4034681, 4034663, 4038792, 4038774, 4041693, 4041685, 4048958, 4050946, 4054519, 4056895, 4057401, 4074594, 4075212, 4088876, 4088882, 4093114, 4093121 > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                               INFECTED UPDATES                               -
echo --------------------------------------------------------------------------------
echo -                    The infected updates are being removed.                   -
echo -                   This process could take up to 5 minutes.                   - 
echo --------------------------------------------------------------------------------
echo -                   Windows RT 8.1 will reboot in 30 seconds.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:testmode
cls
PowerShell.exe chcp 437 > NUL
PowerShell.exe bcdedit /set '{current}' loadoptions ' /TÒSTSIGNING' > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                   TEST MODE                                  -
echo --------------------------------------------------------------------------------
echo -               Your device has succesfully booted in Test Mode.               -
echo --------------------------------------------------------------------------------
shutdown -t 30 -r -f > NUL
echo --------------------------------------------------------------------------------
echo -                   Windows RT 8.1 will reboot in 30 seconds.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu

:normalmode
cls
PowerShell.exe bcdedit /deletevalue loadoptions > NUL
echo --------------------------------------------------------------------------------
echo -               [WINDOWS RT 8.1] Development Tool V3.0 BUILD 0418              -
echo -                                  NORMAL MODE                                 -
echo --------------------------------------------------------------------------------
echo -              Your device has succesfully booted in Normal Mode.              -
echo --------------------------------------------------------------------------------
shutdown -t 30 -r -f > NUL
echo --------------------------------------------------------------------------------
echo -                   Windows RT 8.1 will reboot in 30 seconds.                  -
echo --------------------------------------------------------------------------------
pause > NUL
goto mainmenu