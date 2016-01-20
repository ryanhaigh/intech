@echo off

::Script to get a list of scopes and leases for each server

::Install dhcp helper into netsh

netsh add helper dhcpmon.dll

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
netsh dhcp server %BNE% show scope >> %FILE%
netsh dhcp server %BNE% scope %BNEMAIN%.0 show clients 1 >> %FILE%
netsh dhcp server %BNE% scope %BNEWLAN%.0 show clients 1  >> %FILE%
netsh dhcp server %BNE% scope %BNEWLAN%.64 show clients 1 >> %FILE%

::Perth DHCP
echo %SEPARATOR% >> %FILE%
echo PERTH >> %FILE%
echo %SEPARATOR% >> %FILE%
netsh dhcp server %PRT% show scope >> %FILE%
netsh dhcp server %PRT% scope %PRTMAIN%.0 show clients 1 >> %FILE%
netsh dhcp server %PRT% scope %PRTWLAN%.0 show clients 1  >> %FILE%
netsh dhcp server %PRT% scope %PRTWLAN%.64 show clients 1 >> %FILE%

::Townsville DHCP
echo %SEPARATOR% >> %FILE%
echo TOWNSVILLE >> %FILE%
echo %SEPARATOR% >> %FILE%
netsh dhcp server %TVL% show scope >> %FILE%
netsh dhcp server %TVL% scope %TVLMAIN%.0 show clients 1 >> %FILE%
netsh dhcp server %TVL% scope %TVLWLAN%.0 show clients 1  >> %FILE%
netsh dhcp server %TVL% scope %TVLWLAN%.64 show clients 1 >> %FILE%






