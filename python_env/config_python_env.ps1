# #################################################
# Windows Setup Install Apps Script
#
# From dotfiles directory: .\python_env\config_python_env.ps1
#
# #################################################

# #################################################
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\python_env\config_python_env.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression","",
        Justification="Used to call another of my scripts")]
param()  # Dummy to allow above rules to work

# #################################################
Write-Host "`nPython-Env Config Script Started"

# #################################################
$originallocation = "$env:USERPROFILE\dotfiles\python_env"

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
# 1. System Level Python
if (Test-Path (get-command uv.exe).Path)
{
    Write-Host "`nUV found, continuing with UV latest 3.14 Python installation"
    uv python install 3.14 --default  # Install system-wide latest 3.14 and set as default
    uv python list                    # List installed Python versions
}
else
{
    Write-Host "`nUV not installed. Trying to install UV first..."
    # See `.\win_setup\install\install_apps.ps1` for this install
    choco install -y uv
    Write-Host "`nUV installation completed. Restart this script."
    exit
}

# #################################################
# 2. System Tools
Write-Host "`nInstalling System Tools with UV"
# If already installed, UV will return "`xxx` is already installed"
uv tool install ruff
uv tool install justpath
uv tool install pre-commit

# List tools folder
$ToolsDir = uv tool dir
Get-ChildItem $ToolsDir

# #################################################
# 3. Ruff Configuration
Write-Host "`nCreating SymbolicLink for root Ruff Configuration"
# Force create SymbolicLink's and assign to $null to suppress output of New-Item cmdlet
$null = New-Item -ItemType SymbolicLink -Force -Path "$env:USERPROFILE\.ruff.toml" -Target "$originallocation\.ruff.toml"

# #################################################
# 4. VSCode Settings and Extensions
Invoke-Expression "$originallocation\vscode\vscode_settings.ps1"

# #################################################
# End of Script
Write-Host "`nPython-Env Config Script Completed"
