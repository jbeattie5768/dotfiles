# #################################################
# Configure Editors Script
# #################################################

# From dotfiles directory: .\editors\config_editors.ps1

# Check PS1 script with:
# Invoke-ScriptAnalyzer .\editors\config_editors.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
Write-Host "`nConfig Editors Script Started"

# #################################################
# Check for Admin Rights
# #################################################

# Script needs to be run as Admin <- Windows SymbolicLink's can only be created by Admin
# There seems to be a few ways of checking for Admin rights
if([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
{
    Write-Host "`nRunning as Admin. Continuing..."
}
else
{
    Write-Host "Please run script as Admin. Not currently running as Admin, exiting..."
    exit
}

# #################################################
# Create SymbolicLinks
# #################################################

$SourceFolder = "$env:USERPROFILE\dotfiles\editors"

# #################################################`
# .editorconfig
$SymLinkLocation = "c:\w_local_drive\.editorconfig"  # Don's use mapped drive (W:\) as it may not exist
if (Test-Path $SymLinkLocation)
{
    Write-Host "`nSymbolicLink already exists at $SymLinkLocation. Doing nothing..."
}
else
{
    Write-Host "`nCreating SymbolicLink at $SymLinkLocation"
    # Assigning to $null to suppress output of New-Item cmdlet
    $null = New-Item -ItemType SymbolicLink -Path $SymLinkLocation -Target $SourceFolder\.editorconfig
}

# #################################################`
# Vim
$SymLinkLocation =` "$env:USERPROFILE\_vimrc"
if (Test-Path $SymLinkLocation)
{
    Write-Host "`nSymbolicLink already exists at $SymLinkLocation. Doing nothing..."
}
else
{
    Write-Host "`nCreating SymbolicLink at $SymLinkLocation"
    # Assigning to $null to suppress output of New-Item cmdlet
    $null = New-Item -ItemType SymbolicLink -Path $SymLinkLocation -Target $SourceFolder\vim\_vimrc
}

# Create .vim folder to store backups and swapfiles. Force creation.
# Could do something like this in _vimrc: `mkdir ~/.vim/swaps`
Write-Host "`nCreating Vim folders at $env:USERPROFILE\.vim"
$null = New-Item -ItemType Directory -Force -Path $env:USERPROFILE\.vim\backupdir
$null = New-Item -ItemType Directory -Force -Path $env:USERPROFILE\.vim\swapdir

# #################################################
# End of Script
# #################################################

Write-Host "`nConfig Editors Script Completed"
