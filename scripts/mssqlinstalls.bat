@ECHO OFF

set SEPARATOR=*****************************************************************************
SET mydate=%DATE:~10,4%%DATE:~7,2%%DATE:~4,2%
SET FILE=C:\sqlinfo_%mydate%.txt

::set IPs
set BNE=\\10.52.0.2
set PRT=\\10.52.8.10
set TVL=\\10.52.4.10

::get the list of sql instances by querying each server
::it is neccessary to use psexec because sqlcmd does not see servers
::in the other offices

psexec %BNE% -h sqlcmd -Lc > %FILE%
psexec %PRT% -h sqlcmd -Lc >> %FILE%
psexec %TVL% -h sqlcmd -Lc >> %FILE%

::for each reported sql instance query record the version
::and the databases contained

for /F %%s in (%FILE%) do (
    echo %SEPARATOR% >> %FILE%
    echo %%s >> %FILE%
    echo %SEPARATOR% >> %FILE%
    sqlcmd -S %%s -l 2 -W -Q "SELECT @@VERSION" >> %FILE%
    sqlcmd -S %%s -l 2 -W -Q "sp_databases" >> %FILE%
    )

::open the file
start %FILE%
