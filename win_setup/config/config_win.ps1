# From dotfiles directory: .\win_setup\config\config_win.ps1
#
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\win_setup\config\config_win.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
# Config windows
Write-Host "`nConfig Script Started"

# #################################################
# Check if Admin
# Windows SymbolicLink's can only be created by Admin
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
Write-Host "`nCreating SymLink for Mapped Drives"
# Create symlink in Startup folder to batch file in dotfiles
$symlinklocation  = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\map_local_drive.bat"
$originallocation = "$env:USERPROFILE\dotfiles\win_setup\config\map_local_drive.bat"
New-Item -ItemType SymbolicLink -Path $symlinklocation -Target $originallocation

# Even though we are Admin, we can run the batch file
&cmd /c %APPDATA%\Microsoft\Windows\Start^ Menu\Programs\Startup\map_local_drive.bat

# #################################################
# Windows Explorer preferred Settings - not sure all of these work!
Write-Host "`nSetting Windows Explorer Preferences..."
# Majority taken from:
#  <https://github.com/microsoft/windows-dev-box-setup-scripts/blob/master/scripts/FileExplorerSettings.ps1>
$hive = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Show Hidden Files, Folders, Drives
Set-ItemProperty -Path $hive -Name Hidden -Value 1
# Show Protected OS Files
Set-ItemProperty -Path $hive -Name ShowSuperHidden -Value 1
# Show File Extensions
Set-ItemProperty -Path $hive -Name HideFileExt -Value 0
# Hide Drives with No Media
Set-ItemProperty -Path $hive -Name HideDrivesWithNoMedia -Value 0
# Show Full Path in Title Bar
Set-ItemProperty -Path $hive -Name FullPathAddress -Value 1

# Will expand explorer to the actual folder you're in
Set-ItemProperty -Path $hive -Name NavPaneExpandToCurrentFolder -Value 1
# Adds things back in your left pane like recycle bin
Set-ItemProperty -Path $hive -Name NavPaneShowAllFolders -Value 1
# Opens PC to This PC, not quick access
Set-ItemProperty -Path $hive -Name LaunchTo -Value 1

Write-Host "You may need to restart the File Explorer for changes to take effect."

# #################################################
Write-Host "`nConfig Script Completed"
