# Turn off the lights 
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0

# Remove AWS desktop icons 
Remove-Item C:\Users\Default\Desktop\EC2* 

# Disable UAC
Set-ItemProperty "HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system" -Name EnableLUA -Value 0 