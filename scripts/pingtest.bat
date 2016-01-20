@echo off

SET logfile=pingtext.log
SET host=192.168.0.11
echo Host: %host% Time Started: %DATE% %TIME% > %logfile%

:LOOP

@ping -n 1 %host%
if ERRORLEVEL 1 (
	echo %errorlevel%
	echo Connection failure: %DATE% %TIME% >> %logfile%
	)
	goto LOOP
pause