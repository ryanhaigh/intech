@ECHO OFF

::Create a vbscript file for popups
echo Set objArgs = WScript.Arguments >> _MessageBox.vbs
echo messageText = objArgs(0) >> _MessageBox.vbs
echo MsgBox messageText >> _MessageBox.vbs

::Ensure the files are readable
attrib -r %1
attrib -r %2

::If the file is an RS5000 file open with the compare tool
IF /I [%~x1]==[.ACD] call "C:/Program Files/Rockwell Software/RSLogix 5000 Compare/RSLCompare.exe" %1 %2 & exit 0
::If the file is an RS500 file open rs500 and notepad with the file paths
IF /I [%~x1]==[.RSS] ( cscript _MessageBox.vbs "This will open notepad and rs500" & echo Original: %1 > _paths.txt & echo New: %2 >> _paths.txt & start notepad _paths.txt &  call "C:\Program Files\Rockwell Software\RSLogix 500 English\Rs500.exe" & del _paths.txt & exit 0 )
::If none of the above alert user
cscript _MessageBox.vbs "Selected file not recognised as PLC file extension"
del _MessageBox.vbs

::exit 0