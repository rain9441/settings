@echo off

IF EXIST "c:/program files/cmder" GOTO exists

ECHO "Unable to install cmder settings, C:/ProgramFiles/Cmder/ does not exist"
RETURN 0"

:exists

CP -r "%~dp0\ConEmu.xml" "C:/Program Files/Cmder/vendor/conemu-maximus5/"
if %errorlevel% neq 0 exit /b %errorlevel%

echo cmder settings installed successfully

