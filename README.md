# About
Easy-to-use templates for Packer builds, specifically aimed at digital foresnsics workstations. 

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
    - Possibly the biggest selling point of this repo. HashiCorp has completely neglected writing documentation for and providing examples on getting SSH over SSM to _actually_ work. This template solves that. 

## Scripts
Included Powershell scripts for several common configuration tasks:
- Disabling UAC and/or Defender
- Installing binaries (.exe/.msi, unarchived or .7z/.zip) downloaded from a specified s3 bucket
- Installing common apps with [Chocolatey](https://chocolatey.org/)
- Joining a domain using credentials from SecretsManager

# Prerequisites
## Local Host
### AWS CLI
See install instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions).
### Session Manager Plugin
See install instructions [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html).

## Remote Host
### SSM Agent
The SSM agent is pre-installed on almost all AWS Marketplace AMIs. If you are using a custom AMI, see install instructions [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/manually-install-ssm-agent-linux.html).

## IAM Policy
AWS SSM can be enabled at the account level or on individual Instances using an IAM Instance Profile.
### Account
See instructions [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-instance-permissions.html#default-host-management).
### EC2 Instance
See instructions [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-instance-permissions.html#instance-profile-add-permissions).
### User/Role
- The user running the Packer build will require the permissions described [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/getting-started-restrict-access-quickstart.html#restrict-access-quickstart-end-user).

## Networking
### Security Groups
One of the main benefits of AWS SSM is that it requires no inbound access. The Instances' Security Groups do not need any inbound rules in order for Summoner to work.
### VPC Endpoint
For added security, use a VPC Endpoint for AWS SSM See instructions [here](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html). 