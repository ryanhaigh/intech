@echo off

::This bat script is called from the explorer right click menu. It takes
::the current directory and updates the timestamp for all files in that
::directory recursively. Essentially this is a recursive Unix 'touch'.

::registry entry for windows xp: rtouch_explorer.reg

for /f "delims=" %%i in ('dir "%~f1"  /a-d /b /s') do (
echo Updating timestamp for: "%%i"
echo . >> "%%i"
)

:: [HKEY_CLASSES_ROOT\Directory\shell\rtouch]
:: @="UpdateModificationDate"

:: [HKEY_CLASSES_ROOT\Directory\shell\rtouch\command]
:: @="C:\\rtouch.bat %1"

