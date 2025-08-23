oh-my-posh --init --shell pwsh --config ~/jb29_theme.omp.json | Invoke-Expression
(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
(& uvx --generate-shell-completion powershell) | Out-String | Invoke-Expression
