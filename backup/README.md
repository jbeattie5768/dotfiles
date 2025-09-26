# dotfiles\backup

Configuration files for the [FreeFileSync](https://freefilesync.org/) (FFS) backup software.

There is no install for this, the PS1 script only runs the backup, and runs it from this folder.  
At the moment I do this manually, but there is no reason to not add it to the _Task Scheduler_.  By default the FFS Dialog will appear and will require the user to close, although, allegedly, if you click to "_Auto Close_" you will not need to interact with it. I like sees the dialog.

The FFS is assumed to be installed as `C:\Program Files\FreeFileSync\FreeFileSync.exe`.

## Backups

To prevent the "_Warning: Some files will be synchronized as part of multiple base folders._" message (see [this](https://freefilesync.org/forum/viewtopic.php?t=4318) discussion), I've split the backup into two FFS batch files:

- _`Backup_Asus`_: Backup `W:\` and `$USERPROFILE` to primary backup drive
- _`Backup_D2E`_: Backup the primary backup drive (`D:\`) to the secondary backup drive (`E:\`)

Note that SymbolicLinks are not copied as that would require Admin rights.

## Event Logger

I've setup and Event Logger for the backup. Info was taken from [this _stack overflow_ question](https://stackoverflow.com/questions/286060/what-do-i-need-to-change-to-allow-my-iis7-asp-net-3-5-application-to-create-an-e/7848414#7848414)

Use the Windows Event-Viewer to see the log (one line actually). The _Source_ is _`FFS_Backup`_ under "_Windows Logs -> Application_", ID's 100 and 1234.
