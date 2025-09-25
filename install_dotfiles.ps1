# #################################################
# Install dotfiles
# From dotfiles directory: .\install_dotfiles.ps1

# #################################################
# Better to run each of the config scripts in turn
# from PowerShell with Admin rights:
#   cd ~\dotfiles
#   .\win_setup\install\install_apps.ps1
#   .\win_setup\config\config_win.ps1
#   .\editors\config_editors.ps1
#   .\consoles\config_consoles.ps1
#   .\python_env\config_python_env.ps1
#   .\git\config_git.ps1
# See README.md for more details

# #################################################
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\install_dotfiles.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression","",
        Justification="Used to call another of my scripts")]
param()  # Dummy to allow above rules to work

# #################################################
# Config VSCode
Write-Host "`nInstall dotfiles Script Started"

# #################################################
# Check if Admin
# Windows SymbolicLink's can only be created by Admin
if([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
{
    Write-Host "Running as Admin. Continuing..."
}
else
{
    Write-Host "Please run script as Admin. Not currently running as Admin, exiting..."
    exit
}

# #################################################
# Run each of the config scripts in turn
Write-Host "`nRunning each of the config scripts in turn"

Invoke-Expression "$env:USERPROFILE\dotfiles\win_setup\install\install_apps.ps1"
Invoke-Expression "$env:USERPROFILE\dotfiles\win_setup\config\config_win.ps1"
Invoke-Expression "$env:USERPROFILE\dotfiles\editors\config_editors.ps1"
Invoke-Expression "$env:USERPROFILE\dotfiles\consoles\config_consoles.ps1"
Invoke-Expression "$env:USERPROFILE\dotfiles\python_env\config_python_env.ps1"
Invoke-Expression "$env:USERPROFILE\dotfiles\git\config_git.ps1"

# #################################################
# End of Script
Write-Host "`nInstall dotfiles Script Completed`n"
