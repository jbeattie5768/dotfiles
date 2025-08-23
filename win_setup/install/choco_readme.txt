Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

.\python-3.13.3-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir='C:\Python313'
# choco install parsec


=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
choco -?
choco install <pkg> -y  # -y = confirm all prompts
choco install <pkg> --version=<1.2.3> -y
choco install <pkg> --params "<params>"
choco list  # gives package manged and their version 
choco list -v # verbose, list pkg including details
choco outdated
choco upgrade <pkg>
choco upgrade chocolatey
choco upgrade all --noop  # Don't actually do anything

choco version all # deprecated
=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Apps
choco install adobereader -y
choco install googlechrome -y --ignore-checksums
choco install notepadplusplus.install -y
choco install everything -y

# Tools
choco install 7zip.install -y
choco install googledrive -y
#choco install winget -y # part of Win11 anyway
choco install powertoys -y
 
# Development
# choco install powershell-core –force -y  # Fails, use winget instead
choco install microsoft-windows-terminal -y
choco install git.install -y
choco install github-desktop -y
choco install winmerge
# choco install vscode.install -y
choco install vim -y
choco install obsidian -y
choco install hugo-extended -y
choco install nodejs -y
choco install docker-desktop -y

#choco install python3  # Manual install

# Development Misc
choco install wireshark -y
choco install putty -y
choco install graphviz -y

# Apps Misc
choco install calibre -y
choco install audacity -y
choco install microsoft-teams -y
choco install calibre -y
choco install youtube-dl -y
choco install oh-my-posh -y

=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Note pwsh (v7) and windows powershell (v5) are different
winget search Microsoft.PowerShell
winget install --id Microsoft.PowerShell.Preview --source winget
winget install --force Microsoft.VisualStudioCode --override '/VERYSILENT /SP- /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"'

=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
wsl --install

=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Note that the xxx.install is usually a system wide installation and is often the preference for the maintainer. 
See https://www.reddit.com/r/chocolatey/comments/ykqa3r/why_are_some_packages_duplicated_as_xyzinstall/

=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
code --install-extension ms-vscode-remote.remote-wsl

=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Choco package is outdated, download and install manually (defaults and install as local)
https://freefilesync.org/download.php  # need to save the config somewhere

=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=


