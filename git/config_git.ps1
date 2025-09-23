# #################################################
# Git Setup Script
#
# From dotfiles directory: .\git\config_git.ps1
#
# #################################################

# #################################################
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\git\config_git.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################`
Write-Host "`nGit Config Script Started"

# #################################################
$originallocation = "$env:USERPROFILE\dotfiles\git"

# #################################################
# Check if Admin
# Windows SymbolicLink's can only be created by Admin
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
# Get User Details
$name = Read-Host 'What is your username?'
$email = Read-Host 'What is your email?'

# Create separate .gitconfig.user file for user-specific settings
if (Test-Path "$env:USERPROFILE\.gitconfig.user")
{
    Write-Host "`nOverwriting existing .gitconfig.user"
}
else {
    Write-Host "`nCreating new .gitconfig.user"
}
$null = New-Item -Path "$env:USERPROFILE\.gitconfig.user" -ItemType File -Force
Add-Content -Path "$env:USERPROFILE\.gitconfig.user" -Value "[user]`n    name = $name`n    email = $email"

# #################################################
# .gitconfig
Write-Host "`nCreating SymbolicLink for .gitconfig"
# Force create SymbolicLink's and assign to $null to suppress output of New-Item cmdlet
$null = New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.gitconfig" -Target "$originallocation\.gitconfig"

# #################################################
# .gitignore
# Global ignore, can additionally add per project
# Could have added to .gitconfig as `%USERPROFILE%\dotfiles\git\.gitignore`
Write-Host "Creating SymbolicLink for .gitignore"
$null = New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.gitignore" -Target "$originallocation\.gitignore"

# #################################################
# Additional Git Config Settings
# See: https://git-scm.com/docs/git-config

# Default editor is Vi(m), alternative editors could be....
# git config --global core.editor "'C:\Program Files\Notepad++\notepad++.exe'
# git config --global core.editor "'C:\Program Files\Sublime Text\sublime_text.exe' -w"

# git config --global commit.template ~\.gitmessage.txt

# git config --replace --global mergetool.winmerge.cmd "\""C:\Program Files\WinMerge\WinMergeU.exe"\" -e -u -dl \"Base\" -dr \"Mine\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\""

# #################################################
Write-Host "`nGit Config Script Completed"
