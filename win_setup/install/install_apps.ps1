# #################################################
# Windows Setup Install Apps Script
#
# From dotfiles directory: .\win_setup\install\install_apps.ps1
#
# #################################################

# #################################################
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\win_setup\install\install_apps.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '',
        Justification='Using cmd exactly as Chocolatey provides')]

# #################################################
# Optionally pass Args to PS1 script
# ConfigFile is a text file with Choco package names, one per line, in format:
# [package_name --params]
# Default Choco Apps ConfigFile is ".\win_setup\install\choco_apps.cfg"
# Note: If you pass a custom ConfigFile, it must be in the same format as the default
#
# Example Args would be:
# .\win_setup\install\install_apps.ps1 -ConfigFile c:\temp\my_choco_apps.txt
# .\win_setup\install\install_apps.ps1 -DisableChoco $true -DisableWinget $false -DisableWSL $true
# .\win_setup\install\install_apps.ps1 -ConfigFile c:\temp\my_choco_apps.txt -DisableWinget $true -DisableWSL $true
param(
    # Default assumes CWD is dotfiles root
    [string]
    $ConfigFile = ".\win_setup\install\choco_apps.cfg",

    # mainly used for Debug/Testing: $true (disable install ) or $false (enable install)
    [bool]
    $DisableChoco = $false,   # Disable Choco installs
    [bool]
    $DisableWinget = $false,  # Disable WinGet installs
    [bool]
    $DisableWSL = $false,     # Disable WSL install
    [bool]
    $DisableFonts = $false,   # Disable Fonts install
    [bool]
    $DisableScripts = $false  # Disable PowerShell Scripts install
)

# #################################################
Write-Host "`nInstall Script Started"

# #################################################
# Check for Admin Rights
# Script needs to be run as Admin <- not all require admin, but *most* do
# There seems to be a few ways of checking for Admin rights
if([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
{
    Write-Host "`nRunning as Admin. Continuing..."
}
else
{
    Write-Host "`nPlease run script as Admin. Not currently running as Admin, so exiting..."
    exit
}

# #################################################
# Check for Choco
# See <https://chocolatey.org> for Choco
if($DisableChoco){
    Write-Host "Skipping Choco checks"
}
else {
    $chocoinstalled = Get-Command -Name choco.exe -ErrorAction SilentlyContinue
    # Could've also used: 'powershell choco -v'

    # If Choco *is* installed...
    if($chocoinstalled){
        Write-Host "`nChocolatey already installed, trying to update..."
        choco upgrade chocolatey -y
    }
    else{
        Write-Host "`nChocolatey not installed, trying to install..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
}

# #################################################
# 1. Chocolatey
# #################################################

# File(s) to be installed via Chocolatey are listed in "choco_apps.cfg" by default
if($DisableChoco){
    Write-Host "Skipping Choco installs"
}
else{
    Write-Host "`nChoco Install Starting using config file: $ConfigFile`n"

    foreach($line in Get-Content $ConfigFile | Where-Object {$_ -NOTLIKE "#*"}) {
        if ($line.trim()) { # quick check to verify that data is present and not a blank line

            $text = [regex]::matches($line,'(?<=\[).+?(?=\])').value  # Extract data between []
            $text = $text.trim()  # I had an entry with a space at the end, like [xxx ]

            # choco install -y $text  # Does not work if there are params, like `[pkg --version=1.2.3]`
            # Split into PackageName and PackageParameters (if there are any parameters)
            $PkgName,$PkgParams = $text.Split(' ', 2)  # Just bundle multi-params into $PkgParams

            choco install -y $PkgName $PkgParams
        }
    }
}

# #################################################
# 2. WinGet
# #################################################

# WinGet is pre-installed in Win11
# See <https://learn.microsoft.com/en-us/windows/package-manager/winget/> for WinGet
if($DisableWinget){
    Write-Host "Skipping WinGet installs"
}
else{
    Write-Host "`nWinGet Install Starting`n"
    # Note: PowerShell (v7) and Windows Powershell (v5) are different
    # See <https://learn.microsoft.com/en-us/powershell/scripting/whats-new/differences-from-windows-powershell?view=powershell-7.5>
    winget search Microsoft.PowerShell  # Show Versions Available
    winget install --id Microsoft.PowerShell.Preview --source winget  # v7
    winget install --force Microsoft.VisualStudioCode --override '/VERYSILENT /SP- /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"'
    winget install GitHub.Copilot  # CoPilot CLI, will need further configuration after install, see <https://docs.github.com/copilot/cli/getting-started-with-the-copilot-cli> for more details
}
# #################################################
# 3. WSL
# #################################################

# Win11 recognises 'wsl' command out-of-the-box
# See <https://learn.microsoft.com/en-us/windows/wsl/install> for WSL
if($DisableWSL){
    Write-Host "Skipping WSL install"
}
else{
    Write-Host "`nInstalling WSL and Ubuntu-22.04"

    $LinuxDistro = "Ubuntu-22.04"
    # wsl.exe --list --online   # List of available Distros
    wsl --install $LinuxDistro --no-launch
    wsl -s $LinuxDistro         # Set as default (in case of more than one Distro)
    # wsl --list --all          # List Distro's
    # wsl.exe -d $LinuxDistro   # Start Distro
    # You will be asked for username/password when 1st started
}

# #################################################
# 4. Fonts
# #################################################

if($DisableFonts){
    Write-Host "Skipping Fonts install"
}
else{
    Write-Host "`nInstalling Fonts"
    # I want o use the MS Cascadia font family. No idea which ones I need/want so install:
    # Cascadia Code, Cascadia Mono, Cascadia Code PL, Cascadia Mono PL, Cascadia Code NF, Cascadia Mono NF

    # Use this PS1 script: <https://raw.githubusercontent.com/jpawlowski/nerd-fonts-installer-PS/main/Invoke-NerdFontInstaller.ps1>
    # See <https://github.com/ryanoasis/nerd-fonts/discussions/1697>
    # Can use direct, or install with: Install-Script -Name Invoke-NerdFontInstaller
    # We will install direct from the web...very nice PS script!
    & ([scriptblock]::Create((Invoke-WebRequest 'https://raw.githubusercontent.com/jpawlowski/nerd-fonts-installer-PS/main/Invoke-NerdFontInstaller.ps1'))) -Name cascadia-code, cascadia-mono
}

# #################################################
# 5. PowerShell Scripts
# #################################################

# Nice collection of Scripts at <https://github.com/fleschutz/PowerShell>
if($DisableScripts){
    Write-Host "Skipping PowerShell Scripts install"
}
else{
    Write-Host "`nInstalling PowerShell Scripts"
    # <https://github.com/PowerShell/PSScriptAnalyzer>
    Install-Module -Name PSScriptAnalyzer -Force -Scope AllUsers

    # <https://github.com/devblackops/Terminal-Icons>
    Install-Module -Name Terminal-Icons -Repository PSGallery

    # <https://ohmyposh.dev/docs/installation/windows>
    # Install-Module -Name oh-my-posh -Scope CurrentUser -Force  # Currently Done via Choco

    # <https://github.com/PowerShell/PSReadLine>
    # Install-Module -Name PSReadLine -AllowClobber -Force
}

# Set PowerShell Env Variables
# Opt-out of PowerShell Telemetry: <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_telemetry>
[System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 1, 'User')

# #################################################
# 6. Python
# #################################################

Write-Host "`nInstalling UV (Universal Version Manager)"  # See <https://astral.sh/uv/> for UV
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# Ruff and Python installed within `.\python_env\config_python_env.ps1`
Write-Host "`nReminder: Install Python via UV, e.g.,"
Write-Host "uv python install  # Latest Python version"
Write-Host "See .\python_env\config_python_env.ps1 for more details"
# Example manual install of specific Python version:
# .\python-3.13.3-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir='C:\Python313'

# #################################################
# 7. Miscellaneous Installs
# #################################################

Write-Host "`nInstalling Miscellaneous"

# FreeFileSync install
# Choco package is outdated: https://community.chocolatey.org/packages/freefilesync
# Not yet found a way to auto download, instead download and install
# manually (use the defaults and install as local)
Write-Host "`nDownload and install 'FreeFileSync' Manually from: "
Write-Host "<https://freefilesync.org/download.php >`n"
Read-Host 'Press Enter to continue...'

# #################################################
# End of Script
# #################################################

Write-Host "`nInstall Script Completed"
