############ CONFIG ############
$Binaries_Source = "s3://create.alt.delete/tools"
$Working_Dir = "C:\EZ_Packer"
################################

Set-MpPreference -DisableRealtimeMonitoring $true

New-Item $Working_Dir -ItemType Directory -Force
Start-Process aws s3 cp $Binaries_Source $Working_Dir

# Iterate and unzip archives 
Foreach ($Archive in (Get-Item $Working_Dir\* -Include "*.zip", "*.7z")) {
    Write-Host "Extracting $(Archive.Basename)..."
    Expand-Archive $Archive "C:\Packer_temp"
}

# Iterate and run installs
Foreach ($Install in (Get-Item "C:\Packer_temp\*" -Include "*.exe", "*.msi")) {
    Write-Host "Installing $(Install.Basename)..."
    # If .exe, use every possible quiet/silent switch as superfulous swtiches are ignored 
    If ($Install.Extension -eq ".exe") {
        Start-Process $Install -ArgumentList "/q /Q /s /S /quiet /silent /v/qn" -Wait
    }
    # If .msi, only use /q as superfulous switches cause errors
    If ($Install.Extension -eq ".msi") { 
        Start-Process $Install -ArgumentList "/q" -Wait
    }
}

Remove-Item "C:\Packer_temp" -Recurse -Force