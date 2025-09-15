# From dotfiles directory: .\vscode\vscode_extensions.ps1
#
# VSCode Extensions Export/Import Script
#
# Use VSCode to echo the installed extensions from $env:USERPROFILE\.vscode\extensions
# Write results to `vscode_extensions.txt`
#
# Read extensions one at a time from `vscode_extensions.txt`, install each with
# `code --install-extension <extension>`
#
# ls $env:USERPROFILE\.vscode\extensions  # Show Extensions directory
#
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\vscode\vscode_extensions.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
$Title = "VSCode Extensions"
$ExtensionsFile = ".\vscode\vscode_extensions.txt"  # File to store extensions list

Write-Host “`n================ $Title ================”
Write-Host “`n1: Press ‘1’ to export current user extensions and write them to $ExtensionsFile.”
Write-Host “2: Press ‘2’ to import extensions into VSCode from $ExtensionsFile.”
Write-Host “x: Anything else to quit.”

# #################################################
$UserInput = Read-Host “`nPlease make a selection”
switch ($UserInput)
{
    # #################################################
    ‘1’ {
            # Clear-Host  # Clear Console
            ‘You chose option #1’
            code --list-extensions | ForEach-Object { "$_" } | Out-File $ExtensionsFile
            Write-Host "`nExtensions exported to $ExtensionsFile`n"
    }
    # #################################################
    ‘2’ {
            # Clear-Host  # Clear Console
            ‘You chose option #2’
            foreach($line in Get-Content $ExtensionsFile) {
                if($line.trim()) {  # Skip empty lines...likely to be one at EOF
                    code --install-extension $line
                }
            }
    }
}
