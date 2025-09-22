# #################################################
# Configure Consoles Script
# #################################################

# From dotfiles directory: .\consoles\config_consoles.ps1

# Check PS1 script with:
# Invoke-ScriptAnalyzer .\consoles\config_consoles.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
Write-Host "`nConfig Consoles Script Started"

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
$SourceFolder = "$env:USERPROFILE\dotfiles\consoles"

# Note: Force writing the SymbolicLink as a default file may already have been created.
#       Assign to $null to suppress output of New-Item cmdlet.

# #################################################`
# 1. PowerShell Profile
$SymLinkLocation = "$env:USERPROFILE\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Write-Host "`nCreating SymbolicLink at $SymLinkLocation"
$null = New-Item -ItemType SymbolicLink -Force -Path $SymLinkLocation -Target $SourceFolder\Microsoft.PowerShell_profile.ps1

# #################################################`
# 2. Windows Terminal Settings
$SymLinkLocation = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Write-Host "`nCreating SymbolicLink at $SymLinkLocation"
$null = New-Item -ItemType SymbolicLink -Force -Path $SymLinkLocation -Target $SourceFolder\settings.json
# We do not worry about the `state.json` and `elevated-state.json` Terminal files

# #################################################`
# 3. Oh-My-Posh Theme
$SymLinkLocation = "$env:USERPROFILE\jb29_theme.omp.json"
Write-Host "`nCreating SymbolicLink at $SymLinkLocation"
$null = New-Item -ItemType SymbolicLink -Force -Path $SymLinkLocation -Target $SourceFolder\jb29_theme.omp.json

# #################################################`
# 4. Bashrc
$SymLinkLocation = "$env:USERPROFILE\.bashrc"
Write-Host "`nCreating SymbolicLink at $SymLinkLocation"
$null = New-Item -ItemType SymbolicLink -Force -Path $SymLinkLocation -Target $SourceFolder\.bashrc
# We do not worry about the `.bash_history` and `.bash_profile` Bash files

# #################################################
# End of Script
# #################################################

Write-Host "`nConfig Consoles Script Completed"
