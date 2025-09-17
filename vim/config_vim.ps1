# From dotfiles directory: .\vim\config_vim.ps1
#
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\vim\config_vim.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################`
# SymLinks can only be created by Admin
Write-Host "`nVIM Config Script Started"
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

# #################################################`
# Create SymLink in %HOME% to the Windows VIM config (leading underscore)
Write-Host "`nVIM Config _vimrc Symlink Creation"
New-Item -ItemType SymbolicLink -Force -Path $env:USERPROFILE\_vimrc -Target $env:USERPROFILE\dotfiles\vim\_vimrc

# #################################################`
# Create .vim folder to store backups, etc
# Could do something like this in _vimrc: `mkdir ~/.vim/swaps`
New-Item -ItemType Directory -Force -Path $env:USERPROFILE\.vim\backupdir
New-Item -ItemType Directory -Force -Path $env:USERPROFILE\.vim\swapdir
