# dotfiles\win_setup

## Chicken and Egg

For a new setup you need 2 things:

1. The files on your local machine
   1. Copy the files from GitHub to your local machine
      * `.\dotfiles\win_setup\install\install_apps.ps1`
      * `.\dotfiles\win_setup\install\choco_apps.cfg`
   2. Or install Git manually and clone the repo
      * `winget install --id=Git.Git  -e`
2. Powershell to run the Scripts
   1. Win11 comes with the basic PS, that should be enough to get started
   2. Or install manually
      * `winget install --id=Microsoft.PowerShell.Preview  -e`

For Chocolatey, the PS1 script will try to install or upgrade Chocolatey. Otherwise install manually: `winget install --id=Chocolatey.Chocolatey  -e`

## dotfiles\win_setup\install

`choco_apps.cfg`                       # Apps to be installed via Choco  
`.\win_setup\install\install_apps.ps1` # Powershell script to install apps for new Windows PC  

By default the `install_apps.ps1` script will install application via Chocolatey listed in the `.win_setup\install\choco_apps.cfg` file.  
You can pass al alternative application file to the sctipt via the `-ConfigFile` argument, e.g., :

`.\win_setup\install\install_apps.ps1 -ConfigFile c:\temp\my_choco_apps.txt`

If you pass a custom ConfigFile, it must be in the same format as the default, i.e., `[package_name <optional_params>]`. In addition, each line of the ConfigFile file needs to be one of the following:

* Empty
* Starts with #
* Starts with [

There are further optional arguments for the scripts, mainly used for Debug/Test purposes. The defaults are:

* `-DisableChoco $false`
* `-DisableWinget $false`
* `-DisableWSL $false`

See the PS1 script for their use, but basically if enabled they disable the install of that section of the script.

## dotfiles\win_setup\config

`.\win_setup\config\config_win.ps1`    # Map local drives and setup File Explorer as I like it  
`map_local_drive.bat`                  # Map Local Drives Batch file to link from

---

## Not Yet Added

* PYTHONPATH (I don’t yet use this, but I have plans!)
* `uv tool install justpath`  # <https://github.com/epogrebnyak/justpath>
* Username by default uses first five char of MS Acct. To change follow:
  * <https://www.elevenforum.com/t/change-name-of-user-profile-folder-in-windows-11.2133/>

--

### Choco Commands..as a reminder

`choco --help`  # Help, same as 'choco -?'

`choco install -y <pkg>`  # -y = confirm all prompts  
`choco install <pkg> --version=<1.2.3> -y`  
`choco install <pkg> --params "<params>"`  
`choco install -y <pkg> --noop`  # Don't actually do anything

`choco list`     # gives package managed and their version  
`choco list -v`  # verbose, list pkg including details  

`choco outdated` # Get info about outdated packages
`choco upgrade <pkg>`  
`choco upgrade chocolatey`  
`choco upgrade all --noop`  # Similar to 'choco outdated'

`choco version all` # deprecated
