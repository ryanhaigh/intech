@ECHO OFF

::This bat script will use the sysinternals application 'handle' to poll
::the file "Copy of" and log when the program which has the file handle
::changes

:: first run condition to log current handle
SET OUT2=""

:START
::get info on file handle and store in OUT1
::if the process with the file open changes OUT1 != OUT2
FOR /F "tokens=*" %%A IN ('handle.exe "Copy of"') DO SET OUT1=%%A
IF not "%OUT1%"=="%OUT2%" goto LOG

:RESUME
::get the file handle info again, wait 5 secs and loop
FOR /F "tokens=*" %%A IN ('handle.exe "Copy of"') DO SET OUT2=%%A
SLEEP 5
GOTO START

:LOG
:: log the date, time and new process which has the file handle open
FOR /F "tokens=*" %%A IN ('date /t') DO SET date=%%A
FOR /F "tokens=*" %%A IN ('time /t') DO SET time=%%A
echo %date%- %time% >> handle.log
echo %OUT1% >> handle.log
GOTO RESUME
