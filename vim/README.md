# config-files\vim

`_vimrc`  # Windows config file (`.vimrc` equivalent for Windows)  
`config_vim.ps1`  # Powershell script to link `_vimrc` in home folder

## Vim on Windows

`.vim`     # Folder I create for holding backup and swapfiles  
`_viminfo` # Vim generated file, see `:help viminfo`, stored in `.vim`  
`_vimrc`   # Personal Vim settings for Windows. SymLink created in $HOME  
`.netrwhist` # Vim generated file, history file of folders, stored in `.vim`

Places for your personal config file, from <https://vimhelp.org/starting.txt.html#vimrc>:

* **MS-Windows**    `$HOME/_vimrc`, `$HOME/vimfiles/vimrc` or `$VIM/_vimrc`
* Linux         `$HOME/.vimrc` or `$HOME/.vim/vimrc`

Choco installs Vim into `C:\tools\vim`, although to run the command `vim` it actually uses a batch file at `C:\Windows\vim.bat` as `c:\tools` is not on the Path. Check on PowerShell with `(gcm vim).Path`.

## ToDo

1. _.editorconfig_ is supported out of the box (Vim >= 9.0.1799).
   * Use it instead of setting in the __vimrc_ config file.
   * See `:help editorconfig`.

## Vim Commands...as a reminder

`:echo $MYVIMRC`  # Show which config file was used  
`:message`  # Show messages, especially if you get "_Press ENTER or type command to continue_" when starting Vim
