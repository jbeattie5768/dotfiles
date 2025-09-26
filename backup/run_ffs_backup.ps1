# #################################################
# FreeFileSync Backup Script
#
# From dotfiles directory: .\backup\run_ffs_backup.ps1

# Invoke-ScriptAnalyzer .\backup\run_ffs_backup.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
Write-Host "`nFreeFileSync Backup Script Started"

# #################################################
# Define Variables
$HostName = hostname
$FfsExe = "C:\Program Files\FreeFileSync\FreeFileSync.exe"
$JobsPath = "$env:USERPROFILE\dotfiles\backup"
$JobBatches = "Backup_Asus.ffs_batch", "Backup_D2E.ffs_batch"
$Sep = "\"

# #################################################
# Runs the defined ffs_batch(s) and waits for it to finish.
# Returns the exitcode/returncode.
foreach ($Job in $JobBatches)
{
    Write-Host "`nStarting FreeFileSync backup job $Job on $HostName..."
    $res = Start-Process $FfsExe "$JobsPath$Sep$Job" -wait -PassThru
    $res.HasExited
    $res.exitcode

    # Write EventLog based on return code (exitcode): 0 = success, 1 = warning, 2 = error, 3 = aborted
    # You have to add the event source before a log can successfully be created: New-EventLog -LogName Application -Source "FFS_Backup"
    if ($res.exitcode -like "0") {
        Write-EventLog -LogName Application -Source "FFS_Backup" -EventId 100 -Message "$JobBat1 completed without error."
    }
    else {
        Write-EventLog -LogName Application -Source "FFS_Backup" -EventId 100 -Message "$JobBat1 completed WITH error or warnings. Exit code: $($res.exitcode)" -EntryType Warning
    }
}

