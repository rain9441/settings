@echo off

IF EXIST "c:/program files/cmder" GOTO exists

ECHO "Unable to install cmder settings, C:/ProgramFiles/Cmder/ does not exist"
RETURN 0"

:exists

CP -r "%~dp0\settings" "C:/Program Files/Cmder/config/"
if %errorlevel% neq 0 exit /b %errorlevel%

CP -r "%~dp0\user-ConEmu.xml" "C:/Program Files/Cmder/config/"
if %errorlevel% neq 0 exit /b %errorlevel%

echo cmder settings installed successfully

