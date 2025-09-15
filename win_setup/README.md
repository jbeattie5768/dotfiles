# dotfiles\win_setup

## dotfiles\win_setup\install

`choco_apps.cfg`                       # Apps to be installed via Choco  
`.\win_setup\install\install_apps.ps1` # Powershell script to install apps for new Windows PC  

## dotfiles\win_setup\config

`.\win_setup\config\config_win.ps1`    # Map local drives and setup File Explorer as I like it  
`map_local_drive.bat`                  # Map Local Drives Batch file to link from

---

## Not Yet Added

- PYTHONPATH (I don’t yet use this, but I have plans!)
- Chrome configuration is done automatically with sign-in
- `uv tool install justpath`  # <https://github.com/epogrebnyak/justpath>
- Username by default uses first five char of MS Acct. To change follow:
  - <https://www.elevenforum.com/t/change-name-of-user-profile-folder-in-windows-11.2133/>

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
