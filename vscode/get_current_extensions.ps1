# use VSCode to echo the installed extenstions from %USERPROFILE%\.vscode\extensions
# Write results to Out-File after prefixing each extension with
# "code --install-extension"
# Can run resulting file to install extensions to VSCode
#
# ls $env:USERPROFILE\.vscode\extensions  # Show Extensions directory
#

code --list-extensions | % { "code --install-extension $_" } | Out-File .\import_extensions.ps1
