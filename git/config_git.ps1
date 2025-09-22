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

# #################################################
# First time setup
$name = Read-Host 'What is your username?'
$email = Read-Host 'What is your email?'
git config --global user.name "$name"
git config --global user.email "$email"

# Default editor is Vi(m)
# git config --global core.editor "'C:/Program Files/Notepad++/notepad++.exe'
# git config --global core.editor "'C:/Program Files/Sublime Text/sublime_text.exe' -w"

git config --global init.defaultBranch main
# git config --global commit.template ~/.gitmessage.txt

# See: https://stackoverflow.com/questions/1967370/git-replacing-lf-with-crlf
git config --system core.autocrlf false

# Merge Tool: note that git uses `merge.tool` and `mergetool`, two different commands
git config --global merge.tool winmerge
# git config --global mergetool.keepBackup false
git config --replace --global mergetool.winmerge.cmd "\""C:\Program Files\WinMerge\WinMergeU.exe"\" -e -u -dl \"Base\" -dr \"Mine\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\""
git config --global mergetool.prompt false

# Global ignore, can additionally add per project
git config --global core.excludesfile %USERPROFILE%\dotfiles\git\.gitignore  # Global `.gitignore` file

# #################################################
# git config --list --show-origin # Display config and file location

# #################################################
Write-Host "Config Script Completed"
