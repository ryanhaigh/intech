:: Copy remote job
@echo off

:: This is a modified version of the archive job script used to copy more recent
:: or new files from the remote office servers (Townsville and Perth) to the 
:: Brisbane server

:: Note that the hardcoded paths refer to the temporary location currently used
:: due to a failure of the Brisbane server raid array.

:: Set variables
:: Second argument is the mode - either DRYRUN or blank (meaning execute)
set MODE=%~2
:: Expects to be running on the Brisbane file server and checks this later
set HOST=BNE-FS01
:: First argument is the directory name of the job - not the full path
::set JOB=1116 MRM Water Management
set JOB=%~1

:: Temporarily set current to the location of the restored files
::set CURRENT=D:\Data\Jobs\%JOB%
set CURRENT=E:\Restore\Data\Jobs\%JOB%

set LOG=%CURRENT%\ARCHIVE.LOG
set ALTLOG=%~dp0\ARCHIVE.LOG
set PRT=\\10.52.8.12\Data\Jobs\%JOB%
set TVL=\\10.52.4.12\Data\Jobs\%JOB%


:: Check script is running on BNE file server
if NOT %COMPUTERNAME%==%HOST% (
    echo This script must be run on the machine %HOST%
    echo The script will now exit
) else (
    echo.
    echo The job to be archived is %JOB%
    echo The current files are in %CURRENT%
    echo Missing and updated files from %PRT% 
    echo and %TVL% 
    echo will be copied
    echo The log file will be %LOG%
    echo.
    
    if /I %MODE%==DRYRUN (
        echo The mode is set to dry run. Check the log file %ALTLOG%
        echo If you do not wish to proceeed, close the command prompt 
        echo window now
        pause
        echo.
        :: Robocopy command
        echo robocopy "%PRT%" "%CURRENT%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Dry run robocopy PERTH to CURRENT
        robocopy "%PRT%" "%CURRENT%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Robocopy command
        echo robocopy "%TVL%" "%CURRENT%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Dry run robocopy TOWNSVILLE to CURRENT
        robocopy "%TVL%" "%CURRENT%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Indicate completion in log file
        echo Dry run copy of %JOB% complete >> "%ALTLOG%"
        :: Open log
        notepad "%ALTLOG%"
    ) else (
        echo The mode is set to execute. If you do not wish to proceed, close 
        echo the command prompt window now
        pause
        :: Create destination directory
        :: Robocopy PERTH to CURRENT
        robocopy "%PRT%" "%CURRENT%" /XO /E /DCOPY:T /LOG+:"%LOG%" /V /NP    
        :: Robocopy TOWNSVILLE to CURRENT
        robocopy "%TVL%" "%CURRENT%" /XO /E /DCOPY:T /LOG+:"%LOG%" /V /NP
        :: Indicate completion in log file
        echo Copy of %JOB% complete >> "%LOG%"
        :: Open log
        notepad "%LOG%"
    )
)

echo Script complete. Will now exit
pause
exit
