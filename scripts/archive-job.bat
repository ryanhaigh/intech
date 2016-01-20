:: Archive old jobs
@echo off

:: Set variables
set MODE=$~2
::set MODE=DRYRUN
set HOST=BNE-FS01
set JOB=%~1
::set JOB=1116 MRM Water Management
set CURRENT=D:\Data\Jobs\%JOB%
set YEAR=%date:~10,4%
set OLD=D:\Data\OLD\%YEAR%-%JOB%
set LOG=%OLD%\ARCHIVE.LOG
set ALTLOG=%~dp0\ARCHIVE.LOG
set PRT=\\10.52.8.12\Data\Jobs\%JOB%
set TVL=\\10.52.4.12\Data\Jobs\%JOB%


:: Check script is running on BNE file server
::if NOT %COMPUTERNAME%=="BNE-FS01" (
if NOT %COMPUTERNAME%==%HOST% (
    echo This script must be run on the machine %HOST%
    echo The script will now exit
) else (
    echo.
    echo The job to be archived is %JOB%
    echo The current files are in %CURRENT%
    echo And will be archived in %OLD%
    echo Missing and updated files from %PRT% 
    echo and %TVL% 
    echo will be archived in the same location
    echo The log file will be %LOG%
    echo.
    
    if /I %MODE%==DRYRUN (
        echo The mode is set to dry run. Check the log file %ALTLOG%
        echo If you do not wish to proceeed, press close the command prompt 
        echo window now
        pause
        echo.
        :: Command to create destination directory
        echo mkdir "%OLD%"
        :: Robocopy command
        echo robocopy "%CURRENT%" "%OLD%" /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Dry run robocopy JOBS to OLD
        robocopy "%CURRENT%" "%OLD%" /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Robocopy command
        echo robocopy "%PRT%" "%OLD%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Dry run robocopy PERTH to OLD
        robocopy "%PRT%" "%OLD%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Robocopy command
        echo robocopy "%TVL%" "%OLD%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Dry run robocopy TOWNSVILLE to OLD
        robocopy "%TVL%" "%OLD%" /XO /E /DCOPY:T /LOG+:"%ALTLOG%" /V /NP /L
        :: Command to set OLD as read only
        echo attrib +R /S /D "%OLD%"
        :: Command to delete files from BNE
        echo rmdir "%CURRENT%" /S
        :: Command to delete files from PRT
        echo rmdir "%PRT%" /S
        :: Command to delete files from TVL
        echo rmdir "%TVL%" /S
        :: Indicate completion in log file
        echo Dry run arvhiving of %JOB% complete >> "%ALTLOG%"
        :: Open log
        notepad "%ALTLOG%"
    ) else (
        echo The mode is set to execute. If you do not wish to proceed, close 
        echo the command prompt window now
        pause
        :: Create destination directory
        mkdir "%OLD%"
        :: Robocopy JOBS to OLD
        robocopy "%CURRENT%" "%OLD%" /E /DCOPY:T /LOG+:"%LOG%" /V /NP
        :: Robocopy PERTH to OLD
        robocopy "%PRT%" "%OLD%" /XO /E /DCOPY:T /LOG+:"%LOG%" /V /NP    
        :: Robocopy TOWNSVILLE to OLD
        robocopy "%TVL%" "%OLD%" /XO /E /DCOPY:T /LOG+:"%LOG%" /V /NP
        :: Set OLD as read only
        attrib +R /S /D "%OLD%"
        :: Delete files from BNE
        echo Removing %CURRENT% >> "%LOG%"
        rmdir "%CURRENT%" /S /Q
        :: Delete files from PRT
        echo Removing %PRT% >> "%LOG%"
        rmdir "%PRT%" /S /Q
        :: Delete files from TVL
        echo Removing %TVL% >> "%LOG%"
        rmdir "%TVL%" /S /Q
        :: Indicate completion in log file
        echo Archiving of %JOB% complete >> "%LOG%"
        :: Open log
        notepad "%LOG%"
    )
)

echo Script complete. Will now exit
pause
exit
