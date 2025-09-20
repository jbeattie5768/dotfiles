# dotfiles\win_setup

Intended to be used for a new Windows install.  
Will install various applications.

---

## Chicken and Egg

For a new setup you need 2 things:

1. The files on your local machine
   1. **Recommended**: Copy the files from GitHub to your local machine:
      * `.\dotfiles\win_setup\install\install_apps.ps1`
      * `.\dotfiles\win_setup\install\choco_apps.cfg`
   2. Or install Git manually and clone the repo:
      * `winget install --id=Git.Git  -e`
2. Powershell to run the Scripts
   1. **Recommended**: Win11 comes with the basic PS, that should be enough to get started
   2. Or install manually:
      * `winget install --id=Microsoft.PowerShell.Preview  -e`

For Chocolatey, the PS1 script will try to install or upgrade Chocolatey. Otherwise install manually:

* `winget install --id=Chocolatey.Chocolatey  -e`

---

## Git Clone

```pwsh
cd $env:USERPROFILE  # cd ~
git clone https://github.com/jbeattie5768/dotfiles.git
cd dotfiles          # Scripts, etc, assume this is the CWD
```

---

## dotfiles\win_setup\install

```pwsh
# PowerShell with Admin rights
.\win_setup\install\install_apps.ps1
```

This is the main Powershell PS1 script that will install applications for a new Windows PC. This PS1 script needs ot be run with _**Admin**_ rights.

Installs as part of the PS1 script will be via:

1. Chocolatey
2. WinGet
3. WSL
4. Fonts
5. PowerShell Scripts
6. Python
7. Miscellaneous Installs

---

### 1. Chocolatey

Chocolatey installs the majority of applications, and those applications are listed in the `choco_apps.cfg` file:

`.win_setup\install\choco_apps.cfg`

This is the default Choco application-list used by the `install_apps.ps1` scripts, **but** you can pass an alternative application-list file to the script via the `-ConfigFile` argument, e.g.,:

```pwsh
.\win_setup\install\install_apps.ps1 -ConfigFile c:\temp\my_choco_apps.txt
```

If you pass a custom ConfigFile, it must be in the same format as the default, i.e., `[package_name <optional_params>]`. In addition, each line of the ConfigFile file needs to be one of the following:

* Empty
* Starts with `#`
* Starts with `[`

---

### 2. WinGet

WinGet is the Microsoft Package Manager, and is included in the Win11 installation, so can easily install various applications.

In the PS1 script this is updating PowerShell to the latest PS7, and also to install VSCode (Choco had given errors with VSCode when i had tried it).

* [WinGet Docs](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
* [WinGet Application Repository](https://winstall.app/)

---

### 3. WSL

The Windows Subsystem for Linux (WSL) is available by default for Win11 (and Win10 build >= 19041), and allows you to install Linux distributions.

You can list available online distributions that you can install with the command:

```pwsh
wsl.exe --list --online
```

The PS1 script wil install the `Ubuntu-22.04` Linux distribution. To change this you will need to edit the PS1 script.

* [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

---

### 4. Fonts

The PS1 script will call the "Nerd-Font PowerShell Script" from GitHub user [Julian Pawlowski](https://github.com/jpawlowski). This allows you to install Nerd-Fonts using the PS1 script from the web, which is a very nice touch.

I am using the Cascadia fonts and install the following:

* Cascadia Code
* Cascadia Mono
* Cascadia Code PL
* Cascadia Mono PL
* Cascadia Code NF
* Cascadia Mono NF

These are hardcoded in the script, so change the script for the font of your choice.

Use the following to list the available fonts:

```pwsh
# PowerShell Commands
# List all available Fonts
& ([scriptblock]::Create((iwr 'https://to.loredo.me/Install-NerdFont.ps1'))) -List All

# List the Cascadia Fonts
& ([scriptblock]::Create((iwr 'https://to.loredo.me/Install-NerdFont.ps1'))) -List cascadia
```

* [GitHub Repo for PS Web Installer for Nerd Fonts](https://github.com/jpawlowski/nerd-fonts-installer-PS)
* [GitHub Discussion for PS Script](https://github.com/ryanoasis/nerd-fonts/discussions/1697)

---

### 5. PS1 scripts

PowerShell scripts to install.  

---

### 6. Python

This is now done via UV (installed via Choco).  
The script now only prints a reminder to install via UV.

---

### 7. Miscellaneous Installs

A _catch-all_ section for anything else.

---
---

Apart form the `-ConfigFile` PS1 script argument, there are further optional arguments for the scripts, mainly used for Debug/Test purposes. The defaults are:

* `-DisableChoco $false`
* `-DisableWinget $false`
* `-DisableWSL $false`
* `-DisableFonts $false`

See the PS1 script for their use, but basically if enabled they disable the install of that section of the script.

---

## dotfiles\win_setup\config

```pwsh
# PowerShell with Admin rights
.\win_setup\config\config_win.ps1
```

This PS1 script configures Windows This PS1 script needs ot be run with _**Admin**_ rights.

A SymbolicLink is created to map a local drive. The SymbolicLink links the `map_local_drive.bat` file to the startup folder:

* `"$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"`

A number of changes to the File Explorer settings are made.

---
---

## Not Yet Added

* `PYTHONPATH` - I don’t yet use this, but I have plans!
* `uv tool install justpath`  # <https://github.com/epogrebnyak/justpath>
* The _`$USERPROFILE`_ folder may not be the same as _`$USERNAME`_. Annoyingly, by default Win11 uses the first five characters of your MS Account for the _`$USERPROFILE`_ folder. If that does not match your _`$USERNAME`_, change it by following:
  * <https://www.elevenforum.com/t/change-name-of-user-profile-folder-in-windows-11.2133/>

---

## Choco Commands...as a reminder

`choco --help`  # Help, same as 'choco -?'

`choco install -y <pkg>`  # -y = confirm all prompts  
`choco install <pkg> --version=<1.2.3> -y`  
`choco install <pkg> --params "<params>"`  
`choco install -y <pkg> --noop`  # Don't actually do anything

`choco list`     # gives package managed and their version  
`choco list -v`  # verbose, list pkg including details  

`choco outdated` # Get info about outdated packages
`choco upgrade <pkg>`  
`choco upgrade chocolatey`  
`choco upgrade all --noop`  # Similar to 'choco outdated'

`choco version all` # deprecated

---
