REM \\INTECH-SBS\Clients\Setup\setup.exe /s INTECH-SBS

rem net time \\W2K8FS0 /set /yes 

for /f "delims=[] tokens=2" %%a in ('ping -4 %computername% -n 1 ^| findstr "["') do (set thisip=%%a)
echo %date%,%time%,%username%,%computername%,%userdnsdomain%,%thisip% >> \\10.52.0.4\Data\USERLOGIN.log
echo %date%,%time%,%username%,%computername%,%userdnsdomain%,%thisip% >> C:\USERLOGIN.log

net use * /del /y
net use P: \\bne-fs01\dbase
net use Q: \\per-fs01\dbase
net use Z: \\file_server\Data
net config server /autodisconnect:-1
