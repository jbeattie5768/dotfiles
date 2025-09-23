oh-my-posh --init --shell pwsh --config ~/jb29_theme.omp.json | Invoke-Expression
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression

# Reload profile with: . $PROFILE
# View all Aliases with: Get-Alias
Set-Alias np "C:\windows\notepad.exe"
Set-Alias npp "C:\Program Files\Notepad++\notepad++.exe"
Set-Alias edit npp
Set-Alias vi vim
Set-Alias history Get-History

function grep{
    # Recurse from CWD for case-insensitive, e.g. grep *.md "admin rights"
    # Similar to: ls -r *.md | cat | findstr "admin rights"
    Get-ChildItem -Path .\ -Recurse -Include $args[0] | Select-String -Pattern $args[1]
}

function wexe { (get-command $args[0]).Path }  # Equivalent to cmd `where`

function touch {New-Item -ItemType File -Name $args[0]}

# See: get-help get-process -full
# Alternative is: <https://github.com/gsass1/NTop>
function top {
    $NumProcesses = 15
    $SleepSec = 2
    While(1) {
        Get-Process | Sort-Object -Descending -Property cpu | Select-Object -First $NumProcesses | Format-Table -a
        Start-Sleep $SleepSec
        Clear-Host
    }
}
