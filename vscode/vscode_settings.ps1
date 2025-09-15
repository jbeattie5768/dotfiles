# From dotfiles directory: .\vscode\vscode_settings.ps1
#
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\vscode\vscode_settings.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
# Config VSCode
# Windows SymbolicLink's can only be created by Admin

Write-Host "`nConfig Script Started"
# #################################################
# Check if Admin
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
# Map local network drive at login
Write-Host "Creating SymbolicLink's for VSCode Settings"

$symlinklocation  = "$env:USERPROFILE\AppData\Roaming\Code\User"  # Where SymLink is to be
$originallocation = "$env:USERPROFILE\dotfiles\vscode"            # Where actual files are

New-Item -ItemType SymbolicLink -Path $symlinklocation\settings.json -Target $originallocation\settings.json
New-Item -ItemType SymbolicLink -Path $symlinklocation\mcp.json -Target $originallocation\mcp.json
New-Item -ItemType SymbolicLink -Path $symlinklocation\keybindings.json -Target $originallocation\keybindings.json

