# dotfiles\git

## dotfiles\git\config_git.ps1

```pwsh
# PowerShell with Admin rights
.\editors\config_git.ps1
```

Configures Git through Git commands, so it assumes Git has been installed and is on the path.

---

## dotfiles\git\\.gitignore

`.\git\.gitignore` is a global _.gitignore_ file, set in above PS1 script.

Other `.gitignore` files will be included in specific repos/projects

## .gitignore References

- [Git SCM _.gitignore_ Documentation](https://git-scm.com/docs/gitignore)
- [Git hosted collection of _.gitignore_ templates](https://github.com/github/gitignore)

- [Atlassian _.gitignore_ Documentation](https://www.atlassian.com/git/tutorials/saving-changes/gitignore)
- [DataCamp _.gitignore_ Tutorial](https://www.datacamp.com/tutorial/gitignore)
- [freeCodeCamp() _.gitignore_ Tutorial](https://www.freecodecamp.org/news/gitignore-file-how-to-ignore-files-and-folders-in-git/)

- [TopTal _.gitignore_ generator](https://www.toptal.com/developers/gitignore)
- [Example of a .gitignore](https://gist.github.com/octocat/9257657)

---

## Git Config...reminder

- 3 levels of config precedence (scope)
    1. `--system` System-level config (all users, all repositories)
    2. `--global` User-level config
    3. `--local` Project-level config

```pwsh
git config list          # List all set-variables in config file
git config list --system # List from Global config level
git config list --global # List from System config level
git config list --local  # List from Local config level

git config list --show-origin  # Include the file location
git config list --show-origin --show-scope # Include the scope

```
