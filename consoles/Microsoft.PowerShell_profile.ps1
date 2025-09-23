oh-my-posh --init --shell pwsh --config ~/jb29_theme.omp.json | Invoke-Expression
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression

# Reload profile with: . $PROFILE
# View all Aliases with: Get-Alias
# Create new Alias with: New-Alias <alias> <command> [-Option <options
# <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-alias?view=powershell-7.5>
Set-Alias np "C:\windows\notepad.exe"
Set-Alias npp "C:\Program Files\Notepad++\notepad++.exe"
Set-Alias vi vim
Set-Alias history Get-History

function touch {New-Item -ItemType File -Name $args[0]}

# See: get-help get-process -full
# Alternative is: <https://github.com/gsass1/NTop>
function top {
    While(1) {
        Get-Process | Sort-Object -Descending -Property cpu | Select-Object -First 15 | Format-Table -a
        Start-Sleep 2
        Clear-Host
    }
}
