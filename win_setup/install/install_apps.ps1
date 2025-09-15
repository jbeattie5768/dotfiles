
# From dotfiles directory: .\win_setup\install\install_apps.ps1
#
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\win_setup\install\install_apps.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingInvokeExpression', '',
        Justification='Using cmd exactly as Chocolatey provides')]
param()  # Dummy to allow above rules to work

# #################################################
# Assume <danger detected> CWD is dotfiles root
$ChocoAppsFile = ".\win_setup\install\choco_apps.cfg"

# #################################################
# Debug/Testing: $true (disable install ) or $false (enable install)
$DisableChoco = $false    # Disable Choco installs
$DisableWinget = $false   # Disable WinGet installs
$DisableWSL = $false      # Disable WSL install

# #################################################`
# Needs to be run as Admin
# Powershell script to install apps via Chocolatey and WinGet
# See <https://chocolatey.org> for Choco
# See <https://learn.microsoft.com/en-us/windows/package-manager/winget/> for WinGet

Write-Host "`nInstall Script Started"
# #################################################
# Check if Admin
if([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
{
    Write-Host "`nRunning as Admin. Continuing..."
}
else
{
    Write-Host "`nPlease run script as Admin. Not currently running as Admin, exiting..."
    exit
}

# #################################################
# Check if Choco is installed
if($DisableChoco){
    Write-Host "Debug mode, skipping Choco checks"
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
# File to be installed via Chocolatey are listed in "choco_apps.cfg"
#
if($DisableChoco){
    Write-Host "Debug mode, skipping Choco installs"
}
else{
    Write-Host "`nChoco Install Starting"

    foreach($line in Get-Content $ChocoAppsFile | Where-Object {$_ -NOTLIKE "#*"}) {
        if ($line.trim()) { # quick check to verify that data is present and not all spaces
            $text = [regex]::matches($line,'(?<=\[).+?(?=\])').value  # Extract data between []
            $text = $text.trim()  # I had an entry with a space at the end, like [xxx ]...
            # Write-Host "Extracted: $text"
            choco install -y $text
        }
    }

    Write-Host "`nChoco Install Complete"
}

# #################################################
# WinGet installs
if($DisableWinget){
    Write-Host "Debug mode, skipping WinGet installs"
}
else{
    Write-Host "`nWinGet Install Starting`n"
    # Note: PowerShell (v7) and Windows Powershell (v5) are different
    winget search Microsoft.PowerShell  # Show Versions Available
    winget install --id Microsoft.PowerShell.Preview --source winget
    winget install --force Microsoft.VisualStudioCode --override '/VERYSILENT /SP- /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"'
    Install-Module -Name PSScriptAnalyzer -Force  # PowerShell code checker
}
# #################################################
# WSL install
# Win11 recognises 'wsl' command out-of-the-box
if($DisableWSL){
    Write-Host "Debug mode, skipping WSL install"
}
else{
    Write-Host "`nInstalling WSL and Ubuntu-22.04"
    # See <https://learn.microsoft.com/en-us/windows/wsl/install>
    wsl --install Ubuntu-22.04  # Use 'wsl.exe --list --online' for list
    wsl -s Ubuntu-22.04         # Set as default (in case of more than one distro)
    wsl --list --all            # List Distro's
}

# #################################################
# Python install (now handled by UV)
Write-Host "`nReminder: Install Python via UV, e.g.,"
Write-Host "uv python install 3.14  # Latest 3.14 version"
# .\python-3.13.3-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir='C:\Python313'

# #################################################
# FreeFileSync install
# Choco package is outdated: https://community.chocolatey.org/packages/freefilesync
# Not yet found a way to auto download, instead download and install
# manually (use the defaults and install as local)
Write-Host "`nDownload and install 'FreeFileSync' Manually from: "
Write-Host "<https://freefilesync.org/download.php >`n"
Read-Host 'Press Enter to end...'

# #################################################
Write-Host "Install Script Completed"
