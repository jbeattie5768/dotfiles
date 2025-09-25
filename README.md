# Dotfiles

This repository contains configuration files and setup scripts for my Windows 11 PC.  
They are personal to me, but you are welcome to copy and modify what I've done for your own use - but, you use at your own risk!

It is designed to quickly _[sic]_ setup and configure a new MS Windows development environment using PowerShell scripts.  

## Notes

- All scripts are Powershell 7.x scripts.
- All setup scripts require **Admin** rights.
  - SymbolicLinks in Windows can only be created by Admin.
  - Some apps require Admin rights.
- Symbolic links are used in the scripts to keep configuration files in the repo and link them to their required locations.
- See individual subfolder _README.md_ files for more details of each topic.
- While user interactions has been reduced in the scripts, there are occasions where user input is required.

---

## Installation

Run this to install:

```pwsh
# PowerShell
git clone https://github.com/jbeattie5768/dotfiles.git ~\dotfiles
cd ~\dotfiles
```

To install these dotfiles without Git:

```pwsh
# PowerShell
$FullUrl = "https://github.com/jbeattie5768/dotfiles/archive/refs/heads/main.zip"
$SavedFile = "dotfiles.zip"
# Get Zip from GitHub
Invoke-WebRequest -Uri $FullUrl -OutFile $SavedFile
# Unpack Zip to home folder
Expand-Archive -Path $SavedFile -DestinationPath ~
# Rename folder as Zip uses a `xx-main` name
Rename-Item -Path ~\dotfiles-main\ -NewName dotfiles
# Delete Zip 
Remove-Item dotfiles.zip
```

---

## Structure

```text
dotfiles/
├── consoles/         # Terminal, PowerShell, Git Bash, Oh-My-Posh configs
├── editors/          # Vim, EditorConfig, Notepad++ configs
├── git/              # Git configs
├── python_env/       # Python, Ruff, VSCode configs
└── win_setup/        # Windows setup scripts and configs
```

---

## Setup Instructions

### 1. Windows Setup

Run the main install script to install applications and configure system settings:

```pwsh
# PowerShell with Admin rights
.\win_setup\install\install_apps.ps1
```

- Installs apps via Chocolatey and WinGet
  - See `choco_apps.cfg` for the list of Choco Apps to install
- Sets up WSL, fonts, PowerShell scripts, and more

Configure Windows preferences and mapped drives:

```pwsh
# PowerShell with Admin rights
.\win_setup\config\config_win.ps1
```

- Sets File Explorer options and Windows options
- Creates a mapped drive to a local folder

---

### 2. Editors

Configure Editors I use:

```pwsh
# PowerShell with Admin rights
.\editors\config_editors.ps1
```

- Creates symbolic links for `_vimrc` and `.editorconfig`
- Sets Vim backup and swap directories

---

### 3. Consoles

Configure PowerShell, Windows Terminal, Git-Bash, and Oh-My-Posh:

```pwsh
# PowerShell with Admin rights
.\consoles\config_consoles.ps1
```

- Links PowerShell profile, Terminal settings, Bashrc, and theme files

---

### 4. Python Environment

Configure Python, Ruff, and VSCode Python settings:

```pwsh
# PowerShell with Admin rights
.\python_env\config_python_env.ps1
```

- Installs a system-level Python via [UV](https://docs.astral.sh/uv/)
- Installs system-level tools (ruff, justpath, pre-commit, etc)
- Links global Ruff config
- Configures VSCode settings and extensions

---

### 5. Git

Configure global Git settings:

```pwsh
# PowerShell with Admin rights
.\git\config_git.ps1
```

- Prompts for username and email
  - Creates `.gitconfig.user` for the _username_ information
- Creates symbolic links for `.gitconfig` and `.gitignore`

---

## Install All

There is a single PowerShell script that will call all scripts:

```pwsh
# PowerShell with Admin rights
cd ~\dotfiles
.\install_dotfiles.ps1
```

I'd recommend doing them one at a time, adjusting each as you go:

```pwsh
# PowerShell with Admin rights
cd ~\dotfiles
.\win_setup\install\install_apps.ps1
.\win_setup\config\config_win.ps1
.\editors\config_editors.ps1
.\consoles\config_consoles.ps1
.\python_env\config_python_env.ps1
.\git\config_git.ps1
```

---

## References

- [windows-dev-box-setup-scripts](https://github.com/Microsoft/windows-dev-box-setup-scripts)
- [GNU Stow](https://www.gnu.org/software/stow/)
- [PSDotFiles (something similar to GNU Stow for Windows PowerShell)](https://github.com/ralish/PSDotFiles)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [Unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/)
