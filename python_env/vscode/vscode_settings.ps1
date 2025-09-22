# #################################################
# VSCode Settings Script
#
# From dotfiles directory: .\python_env\vscode\vscode_settings.ps1
#
# #################################################

# #################################################
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\python_env\vscode\vscode_settings.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression","",
        Justification="Used to call another of my scripts")]
param()  # Dummy to allow above rules to work

# #################################################
# Config VSCode
Write-Host "`nVSCode Config Script Started"

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
# Check is VSCode Installed
$VscodeInstalled = Get-Command code -ErrorAction SilentlyContinue
if ($VscodeInstalled)
{
    $VscodeResult = code --version
    $VscodeVer, $VscodeHash, $VscodeArch = $VscodeResult.Split(' ', 3)
    Write-Host "`nVSCode found (Ver: $VscodeVer. Arch: $VscodeArch), continuing with VSCode configuration"
}
else
{
    Write-Host "`nVSCode not installed. Trying to install VSCode first..."
    # See `.\win_setup\install\install_apps.ps1` for this install
    winget install --force Microsoft.VisualStudioCode --override '/VERYSILENT /SP- /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"'
    Write-Host "`nVSCode installation completed. Continuing with VSCode configuration"
}

# #################################################
# VSCode Settings
Write-Host "`nCreating SymbolicLink's for VSCode Settings"

$symlinklocation  = "$env:USERPROFILE\AppData\Roaming\Code\User"  # Where SymLink is to be
$originallocation = "$env:USERPROFILE\dotfiles\python_env\vscode" # Where actual files are

# Force create SymbolicLink's and assign to $null to suppress output of New-Item cmdlet
$null = New-Item -ItemType SymbolicLink -Force -Path $symlinklocation\settings.json -Target $originallocation\settings.json
$null = New-Item -ItemType SymbolicLink -Force -Path $symlinklocation\mcp.json -Target $originallocation\mcp.json
$null = New-Item -ItemType SymbolicLink -Force -Path $symlinklocation\keybindings.json -Target $originallocation\keybindings.json

# #################################################
# VSCode Extensions
Invoke-Expression "$env:USERPROFILE\dotfiles\python_env\vscode\vscode_extensions.ps1"

# #################################################
# End of Script
Write-Host "`nVSCode Config Script Completed"
