# #################################################
# VSCode Extensions Export/Import Script
#
# From dotfiles directory: .\python_env\vscode\vscode_extensions.ps1
#
# #################################################

# #################################################
# Check PS1 script with:
# Invoke-ScriptAnalyzer .\python_env\vscode\vscode_extensions.ps1
# Disable rules for this script:
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '',
        Justification='Valid in this use-case for user feedback')]
param()  # Dummy to allow above rules to work

# #################################################
$ExtensionsFile = ".\python_env\vscode\vscode_extensions.txt"  # File to store extensions list

Write-Host “`nSelect What to do With VSCode Extensions...”
Write-Host “1: Enter '1' to export current user extensions and write them to $ExtensionsFile.”
Write-Host “2: Enter '2' to import extensions into VSCode from $ExtensionsFile.”
Write-Host “q: Enter 'q' or any other key to quit and do nothing with VSCode Extensions.”

# #################################################
$UserInput = Read-Host “`nPlease make a selection”
switch ($UserInput)
{
    # #################################################
    '1' {
            # Clear-Host  # Clear Console  # 'You chose option #1'
            code --list-extensions | ForEach-Object { "$_" } | Out-File $ExtensionsFile
            Write-Host "`nExtensions exported to $ExtensionsFile`n"
    }
    # #################################################
    '2' {
            # Clear-Host  # Clear Console # 'You chose option #2'
            foreach($line in Get-Content $ExtensionsFile) {
                if($line.trim()) {  # Skip empty lines...likely to be one at EOF
                    code --install-extension $line
                }
            }
    }
}

# #################################################
# End of Script
Write-Host "`nVSCode Extensions Choice Completed"
