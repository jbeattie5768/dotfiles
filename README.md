# config-files
All my configuration files for shell, editors, and other developer tools.

Something sinilar to GNU Stow for Windows PowerShell:
https://github.com/ralish/PSDotFiles

Powershell can create SymLink's, but only in Admin mode.
PS, Cmd and Bash can create Symlinks, but they are differnt and not compatible. 
Link files are 0 length and under Windows give no preview (they are not acutally a file).

New-Item -ItemType SymbolicLink -Path <lnk> -Target <target>

-Path is the SymLink name
-Target is the Object to be linked to
Both can be paths only (for dir symlink's) or full path and filenames. 

For Cmd it is 

mklimk {opt} <linK> <target> 
Options:
/D for directory
/H for a hard link
/J Creates a Directory Junction

Use in PS with "cmd /c", e.g. cmd /c mklink test2.txt test.py
Still need Admin rights.

