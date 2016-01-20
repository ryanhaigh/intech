@echo off

::Script to get a list of scopes and leases for each server

::set output file and clear existing contents
set FILE=C:\DHCPINFO.txt
echo DHCP INFORMATION FOR INTECH ENGINEERS > %FILE%

set SEPARATOR=*****************************************************************************

::set IPs
set BNE=\\10.52.0.2
set PRT=\\10.52.8.10
set TVL=\\10.52.4.10

::set scope IPs
set BNEMAIN=10.52.0
set BNEWLAN=10.52.2

set PRTMAIN=10.52.8
set PRTWLAN=10.52.10

set TVLMAIN=10.52.4
set TVLWLAN=10.52.6

::Brisbane DHCP
echo %SEPARATOR% >> %FILE%
echo BRISBANE >> %FILE%
echo %SEPARATOR% >> %FILE%
psexec %BNE% -h netsh dhcp server show scope >> %FILE%
psexec %BNE% -h netsh dhcp server scope %BNEMAIN%.0 show clients 1 >> %FILE%
psexec %BNE% -h netsh dhcp server scope %BNEWLAN%.0 show clients 1  >> %FILE%
psexec %BNE% -h netsh dhcp server scope %BNEWLAN%.64 show clients 1 >> %FILE%

::Perth DHCP
echo %SEPARATOR% >> %FILE%
echo PERTH >> %FILE%
echo %SEPARATOR% >> %FILE%
psexec %PRT% -h netsh dhcp server show scope >> %FILE%
psexec %PRT% -h netsh dhcp server scope %PRTMAIN%.0 show clients 1 >> %FILE%
psexec %PRT% -h netsh dhcp server scope %PRTWLAN%.0 show clients 1  >> %FILE%
psexec %PRT% -h netsh dhcp server scope %PRTWLAN%.64 show clients 1 >> %FILE%

::Townsville DHCP
echo %SEPARATOR% >> %FILE%
echo TOWNSVILLE >> %FILE%
echo %SEPARATOR% >> %FILE%
psexec %TVL% -h netsh dhcp server show scope >> %FILE%
psexec %TVL% -h netsh dhcp server scope %TVLMAIN%.0 show clients 1 >> %FILE%
psexec %TVL% -h netsh dhcp server scope %TVLWLAN%.0 show clients 1 >> %FILE%
psexec %TVL% -h netsh dhcp server scope %TVLWLAN%.64 show clients 1 >> %FILE%




