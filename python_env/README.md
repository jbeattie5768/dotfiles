# dotfiles\python_env

## dotfiles\python_env\config_python_env.ps1

```pwsh
# PowerShell with Admin rights
.\python_env\config_python_env.ps1
```

Configures the Python Environment.

I like to have a system-wide Python install that I can run from anywhere.  
Project specific versions are maintained by UV and are installed into a project level Venv.  
These are not handled by this script.

---

## 1. System Level Python

Check that [UV](https://docs.astral.sh/uv/) has been installed, installs via [Chocolatey](https://chocolatey.org/) if it has not been installed.

Assuming UV has been installed, the PS1 script will install the latest python 3.14 release system-wide. UV uses the experimental `--default` option to do this, but I've not seen any trouble with it so far.

## 2. System Tools

Use UV to install a number of system-wide tools/utilities.

For example, [Ruff](https://docs.astral.sh/ruff/), [JustPath](https://github.com/epogrebnyak/justpath), etc.  
See script for current tools/utilities installed.

## 3. Ruff Configuration

 Creates a SymbolicLink to the Ruff root-configuration file.  
 This is held in `$env:USERPROFILE` folder and is the `.ruff.toml` file.

Ruff will check for local project Ruff _TOML_ files, and if not found will eventually get to ths one after checking local scopes.

 No checks for Ruff having been installed are made. It's assumed it already has been, either as part of _Step 2_ or previously installed.

## 4. VSCode Settings and Extensions

VSCode settings are linked via the `.\python_env\vscode\vscode_settings.ps1` script.
