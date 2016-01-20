@echo off

:: Creates a copy of any pdf in the current directory but rotated right.
:: The rotated files are stored in a new directory 'rotated' which is created
:: by the script.
:: The script is hardcoded to expect pdftk.exe in the current directory.

mkdir rotated
forfiles /m *.pdf /C "cmd /c pdftk.exe @file cat 1R output rotated\\@file