packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Find the latest AWS Marketplace Windows 2019 AMI and save it as amazon-ami.win2019
data "amazon-ami" "win2019" {
  filters = {
    name                = "Windows_Server-2019-English-Full-Base*"
    virtualization-type = "hvm"
    root-device-type    = "ebs"
  }
  owners      = ["amazon"]
  region      = "us-east-1"
  most_recent = true
}

# Define the instance to be created and save it as amazon-ebs.win2019
source "amazon-ebs" "win2019" {
  source_ami       = data.amazon-ami.win2019.id
  region           = "us-east-1"
  instance_type    = "m5a.xlarge"
  ami_name         = "my_win2019_ami"
  force_deregister = true

  # Select VPC and subnet to build in
  vpc_id    = ""
  subnet_id = ""

  # Apply IAM Instance Profile to enable SSM
  iam_instance_profile = ""

  # Tell Packer to use WinRM
  communicator   = "winrm"
  winrm_username = "Administrator"
  winrm_insecure = true
  winrm_use_ssl  = true
}

# Build AMI
build {
  sources = ["source.amazon-ebs.win2019"]
  provisioner "powershell" {
    inline = ["Write-Host Connected via SSM at '${build.User}@${build.Host}:${build.Port}'"]
  }
  provisioner "powershell" {
    scripts = [
      "../scripts/domain_join.ps1",
      "../scripts/anything_else.ps1"
    ]
  }
  provisioner "powershell" {
    inline = ["C:/ProgramData/Amazon/EC2-Windows/Launch/Scripts/InitializeInstance.ps1 -Schedule"]
  }
}