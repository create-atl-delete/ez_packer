# Windows Builds

## A note on adding scripts
Packer runs all scripts from a single Powershell terminal and there's no way to get a new terminal outside of restarting the instance. As such, you will not be able to access any new environment variables after installing a programs. 

Instead of `aws s3 cp ...` after installing AWS CLI, use `Start-Process "C:\Program Files\Amazon\AWSCLIV2\aws.exe" -ArgumentList "s3 cp ..."`.

## Using SSH
Reccomend using the SSH-SSM versions. It's more reliable than WinRM.

By default, the key pair that Packer creates during the build and applies to the instance is not configured for use with OpenSSH, so Packer can't connect. You need to pass a user data file to the instance to copy the public key from instance metadata to administrators_authrized_keys. ssh_config.ps1 does that for you.