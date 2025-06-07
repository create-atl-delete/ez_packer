# About
Easy-to-use templated for Packer builds, specifically aimed at digital foresnsics workstations. 

# Ubuntu
## Connections
Supports SSH over SSM

## Scripts
Includes shell scripts for several common configuration tasks:
- Joining an AD domain using credentials from SecretsManager
- Install SANS' [SIFT Workstation](https://www.sans.org/tools/sift-workstation/)

# Windows
## Connctions
Supports the following
- WinRM
- SSH over SSM (recommended)
    - Possibly the biggest selling point of this repo. HashiCorp has completely neglected writing documentation for and providing examples on getting SSH over SSM to work. This template solves that. 

## Scripts
Included Powershell scripts for several common configuration tasks:
- Disabling UAC and/or Defender
- Installing binaries (.exe/.msi, unarchived or .7z/.zip) downloaded from a specfified s3 bucket
- Installing common apps with [Chocolatey](https://chocolatey.org/)
- Joining a domain using credentials from SecretsManager