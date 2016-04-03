# intech

A collection of scripts, registry modifications and potentially other things I use in my dayjob. These things are **rough** using hardcoded paths, ip addresses etc and making a lot of assumptions.

## Registry ##

**DirectoryPathToClipboard:** adds and entry to the right click menu of explorer which places the path to the selected directory on the clipboard - does not handle special characters

**FilePathToClipboard:** adds an entry to the right click menu of explorer which places the path to the selected file on the clipboard - does not handle special files

**Recursive/DirectoryListToClipboard:** adds an entry to the right click menu of explorer which places a list of the current directories contents on the clipboard - does not handle special characters in the path

**Recuresive/DirectoryListToFiles.txt:** adds an entry to the right click menu of explorer which places a list of the current directories contents in a new text files.txt file - does not handle special characters in the path

**MapLocalToL:** adds an entry to the right click menu of explorer allowing the user to quickly map the selected directory to L drive

**MapLocalToN:** adds an entry to the right click menu of explorer allowing the user to quickly map the selected directory to N drive

**AltTabAeroPeakDelay** introduces a delay to the aero peak function initiated when using alt-tab on a Windows 7 machine as the default behaviour is distracting and slow

**Windows 7 Libraries:** there are 3 registry entries which manipulate whether libraries are enabled/disabled/hidden in Windows 7



## Script ##

**add-printers.bat:** removes, installs and sets default printers

**add-user.ps1:** adds a user to active directory and exchange

**archive-job.bat:** archive projects/jobs when they are complete - copies to the archive location - copies new/missing/more recent files from the remote office servers - deletes the original files from all servers - marks the archived files read only - supports simulation through DRYRUN mode

**copy-remote-job.bat:** a modified version of the archive job script used to copy more recent or new files from the remote office servers (Townsville and Perth) to the Brisbane server

**dhcpinfo.bat:** queries the servers for information on dhcp scopes and leases

**dhcpinfo-nopsexec.bat** queries the servers for information on dhcp scopes and leases but does not require psexec

**disable-user.ps1:** disable an active directory user and grant access to their exchange mailbox

**handle.bat:** uses sysinternals handle.exe to monitor and log which application has a handle on an open file

**LOGIN_SCRIPT.bat:** the login script run by all domain clients on login - includes drive maps and logging (that doesn't seem to work reliably)

**mssqlinstance.bat:** queries the servers to get a list of the instances of MS SQL

**pdf-stamp.bat:** uses pdftk to create copies of all pdfs in the current directory with a stamp

**pdf-rotate-left/right.bat:** uses pdftk to create copies of all pdfs in the current directory rotated either left or right 90 degrees

**pingtest.bat:** pings a target repeatedly and logs failures

**plcdiff.bat:** used with bzr-explorer and plc programming to call the appropriate comparison tool for the plc platform being used

**plot-peaks.py:** process a csv file with northing, easting and elevation and plot the position and proximity of peaks

**purge-users.ps1:** remove a user from active directory and exchange optionally keeping a copy of their mailbox

**rtouch.bat:** recursively touch files in the current directory
