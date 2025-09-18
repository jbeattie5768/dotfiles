# DotFiles

`cd $env:USERPROFILE\dotfiles`

---

All my configuration files for shell, editors, and other developer tools.
Also included are some PS install scripts for new PC setup, in the `win_setup` directory.

Powershell can create SymLink's, but only in **Admin** mode.  
**I will use PS**.  
PS, Cmd and Bash can create Symlinks, but they are different and not compatible.  
Link files are 0 length and under Windows give no preview (they are not actually a file).

```pwsh
# PowerShell
New-Item -ItemType SymbolicLink -Path <lnk> -Target <target>
```

`-Path` is the SymLink name  
`-Target` is the Object to be linked to  
Both can be paths only (for dir symlink's) or full path and filenames.

For Cmd it is:

```pwsh
# Command Prompt (cmd)
mklink {opt} <linK> <target>
```

Cmd Options:  
`/D` for directory  
`/H` for a hard link  
`/J` Creates a Directory Junction  

You can use the `mklink` cmd option wihtin PS with `cmd /c`, e.g., `cmd /c mklink test2.txt test.py`  
You will still need Admin rights.

---
## Reference Links

- [windows-dev-box-setup-scripts](https://github.com/Microsoft/windows-dev-box-setup-scripts)
- [GNU Stow](https://www.gnu.org/software/stow/)
- [Something similar to GNU Stow for Windows PowerShell](https://github.com/ralish/PSDotFiles)
