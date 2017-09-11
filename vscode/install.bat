@echo on

CP -r "%~dp0keybindings.json" "%HOME%/AppData/Roaming/Code/User/"
if %errorlevel% neq 0 exit /b %errorlevel%

CP -r "%~dp0settings.json" "%HOME%/AppData/Roaming/Code/User/"
if %errorlevel% neq 0 exit /b %errorlevel%

echo vscode settings installed successfully

