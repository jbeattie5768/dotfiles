# dotfiles\consoles

## dotfiles\consoles\config_consoles.ps1

```pwsh
# PowerShell with Admin rights
.\editors\config_consoles.ps1
```

Creates SymbolicLinks for:

---

## 1. PowerShell Profile

SymbolicLink for the `Microsoft.PowerShell_profile.ps1` configuration file for [PowerShell 7.x](https://learn.microsoft.com/en-us/powershell/scripting/what-is-windows-powershell?view=powershell-7.5).

Use the PS commands:

* `$profile | get-member -name *user*` # List the candidate locations for profile files
* `echo $profile`  # The Current Profile in use

## 2. Windows Terminal

SymbolicLink for the `settings.json` configuration file for [Windows Terminal](https://learn.microsoft.com/en-gb/windows/terminal/).

The Configuration assumes Cascadia Font(s), Git Bash and PowerShell 7 being available.

## 3. Oh-My_posh

The [Oh-My_Posh](https://ohmyposh.dev/) theme, `jb29_theme.omp.json`, to be used for PowerShell and Bash.  
This is my own theme and is in both the PowerShell profile as well as the Bash profile files.

## 4. Bash

SymbolicLink for the `.bashrc` file, which is actually for [Git Bash](https://gitforwindows.org/).
