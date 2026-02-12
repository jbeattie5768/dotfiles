# ############################
# Prompt and Completions
# ############################
oh-my-posh --init --shell pwsh --config ~/jb29_theme.omp.json | Invoke-Expression
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression

# ############################
# Modules
# ############################
# Assumes `Import-Module -Name Terminal-Icons` already done
Import-Module -Name Terminal-Icons

# ############################
# Aliases and Functions
# ############################
# Reload profile with: . $PROFILE
# View all Aliases with: gal
Set-Alias np "C:\windows\notepad.exe"
Set-Alias npp "C:\Program Files\Notepad++\notepad++.exe"
Set-Alias edit npp
Set-Alias vi vim
Set-Alias history Get-History

# View all Functions with: gci function:
function lw { Get-ChildItem | Format-Wide }  # gci | fw

function grep {
    # Recurse from CWD for case-insensitive, e.g. grep *.md "admin rights"
    # Similar to: ls -r *.md | cat | findstr "admin rights"
    Get-ChildItem -Path .\ -Recurse -Include $args[0] | Select-String -Pattern $args[1]
}

function ?? { copilot -p "$args" --allow-all-tools }

function wexe { (get-command $args[0]).Path}  # Equivalent to cmd `where`

function touch { New-Item -ItemType File -Name $args[0] }

function time {  # Time cmds, e.g. time uv run ruff check
    $command = $args -join ' '
    Measure-Command { Invoke-Expression $command | Out-Host }  # Without "Out-Host" there is no cmd output
}

function weather { Invoke-RestMethod https://wttr.in }

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

# ############################
