@echo off

:: Creates a copy of any pdf in the current directory with a stamp applied.
:: The stamped files are stored in a new directory 'stamped' which is created
:: by the script.
:: The script is hardcoded to expect pdftk.exe and background.pdf (containing
:: the stamp) in the current directory.

mkdir stamped
forfiles /m *.pdf /C "cmd /c pdftk.exe @file stamp background.pdf output stamped\\@file
exit
