@echo off
::script to automatically install printers for perth office

::remove existing instances for these printers

echo Removing printers

rundll32 printui.dll,PrintUIEntry /q /dn /n "\\10.52.8.10\KYOCERA_A4"
rundll32 printui.dll,PrintUIEntry /q /dn /n "\\10.52.8.10\KYOCERA_A3"
rundll32 printui.dll,PrintUIEntry /q /dn /n "\\10.52.8.10\KYOCERA_A4-64bit"
rundll32 printui.dll,PrintUIEntry /q /dn /n "\\10.52.8.10\KYOCERA_A3-64bit"
rundll32 printui.dll,PrintUIEntry /q /dn /n "\\10.52.8.10\HPCOLOUR_A4"

::install printers

echo Installing printers

start \\10.52.8.10\KYOCERA_A4
start \\10.52.8.10\KYOCERA_A3
start \\10.52.8.10\HPCOLOUR_A4

::set the default printer

rundll32 printui.dll,PrintUIEntry /y /n "\\10.52.8.10\KYOCERA_A4"
