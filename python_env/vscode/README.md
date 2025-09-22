# dotfiles\python_env\vscode

## dotfiles\python_env\vscode\vscode_settings.ps1

```pwsh
# PowerShell with Admin rights
.\python_env\vscode\vscode_settings.ps1
```

Configures VSCode.

Checks that VSCode has been installed, if not will install it.

Creates SymbolicLinks for the following VSCode configuration files:

* `.\vscode\settings.json`  
* `.\vscode\keybindings.json`
* `.\vscode\mcp.json`  

Optionally installs VSCode Extensions by calling the `.\python_env\vscode\vscode_extensions.ps1` script.  
This script will do one of two things, depending on user input:

1. Export installed VSCode Extensions
   * Use VSCode to echo the installed extensions from `$env:USERPROFILE\.vscode\extensions`
   * Write results to `.\python_env\vscode\vscode_extensions.txt`
2. Import/Install VSCode Extensions
   * Read extensions one at a time from `.\python_env\vscode\vscode_extensions.txt`
   * Install each with `code --install-extension <extension>`
  
Show VSCode Extensions directory with `ls $env:USERPROFILE\.vscode\extensions`

---

## ToDo

* Sufficient until we get _VSCode Sync_ to work
