<powershell>

# Install sshd
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Save the private key from intance metadata to administrators_authorized_keys
New-Item C:\ProgramData\ssh\administrators_authorized_keys -ItemType File -ErrorAction SilentlyContinue
Set-Content C:\ProgramData\ssh\administrators_authorized_keys -Value ((New-Object System.Net.WebClient).DownloadString('http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key'))

# Set appropriate permissions on administrators_authorized_keys by copying them from an arbitrary existing key 
Get-ACL C:\ProgramData\ssh\ssh_host_dsa_key | Set-ACL C:\ProgramData\ssh\administrators_authorized_keys

# Set sshd to automatic and re/start
Set-Service sshd -StartupType "Automatic"
Restart-Service sshd

</powershell>