# dotfiles\editors

## dotfiles\editors\config_editors.ps1

```pwsh
# PowerShell with Admin rights
.\editors\config_editors.ps1
```

Creates SymbolicLinks for:

---

## 1. .editorconfig

SymbolicLink for the `.editorconfig` configuration file.

---

## 2. Notepad++

No config files kept.

Notepad++ has a number of files which it would deem as being "_config_". The default configurations files are located at `$env:USERPROFILE\AppData\Roaming\Notepad++`.  
You can change to another location in **_Settings -> Preferences -> Cloud & Link_**, e.g., `$env:USERPROFILE\dotfiles\editors\notepad++`.

The trouble with this is its more like a backup, or save last settings, than a config setting. I already backup the `$env:USERPROFILE` folders, so if I need to I can get the data from there.

### Notepad++ Plugins

The available Notepad++ Plugin list is at <https://github.com/notepad-plus-plus/nppPluginList/blob/master/doc/plugin_list_x64.md>

The plugins I use are:

* [Compare](https://github.com/pnedev/compare-plugin)
* [EditorConfig](https://github.com/editorconfig/editorconfig-notepad-plus-plus)
* [MarkdownViewerPlusPlus](https://nea.github.io/MarkdownViewerPlusPlus)

---

## 3. Vim

Create SymbolicLink for `_vimrc`, which is the Windows equivalent config file (`.vimrc`).

Force creation of _backupdir_ and _swapdir_ folders in a _.vim_ folder.

### Vim on Windows

* `.vim`     Folder created to hold backup and swap files  
* `_viminfo` Vim generated file, see `:help viminfo`, stored in `.vim`  
* `_vimrc`   Personal Vim settings for Windows. SymbolicLink created in $HOME  
* `.netrwhist` Vim generated file, history file of folders, stored in `.vim`

Places where your personal Vim config file can be located, from <https://vimhelp.org/starting.txt.html#vimrc>, is as follows:

* **MS-Windows**: `$HOME/_vimrc`, `$HOME/vimfiles/vimrc` or `$VIM/_vimrc`
* Linux: `$HOME/.vimrc` or `$HOME/.vim/vimrc`

Choco installs Vim into `C:\tools\vim`, although to run the command `vim`, it actually uses a batch file at `C:\Windows\vim.bat`, as `c:\tools` is not on the Path.  
Check on PowerShell with `(gcm vim).Path` command.

### Vim Commands...as a reminder

* `:echo $MYVIMRC`  # Show which config file was used  
* `:message`  # Show messages, especially if you get "_Press ENTER or type command to continue_" when starting Vim

---

## ToDo

* Sublime3? I do have a license, but tend not to use it.
* Vim: _.editorconfig_ is supported out of the box (Vim >= 9.0.1799).
  * Use it instead of setting in the __vimrc_ config file.
  * See `:help editorconfig`.
