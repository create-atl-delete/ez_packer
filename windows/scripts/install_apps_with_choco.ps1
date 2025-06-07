$Apps = @(
    "googlechrome",
    "7zip",
    "git",
    "awscli",
    "vscode",
    "putty",
)

# Install choco
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Configure choco to complete installs without confirmation 
C:\ProgramData\chocolatey\choco.exe feature enable -n allowGlobalConfirmation

# Install apps
for each ($App in $Apps) {
    Start-Process C:\ProgramData\chocolatey\choco.exe -ArgumentList "install $App" -NoNewWindow -Wait
}