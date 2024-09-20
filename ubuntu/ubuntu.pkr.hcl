packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Find the latest AWS Marketplace Ubuntu AMI and save it as amazon-ami.ubuntu
data "amazon-ami" "ubuntu" {
  filters = {
    name = "Ubuntu_20.04-x86_64s*"
    virtualization-type = "hvm"
    root-device-type    = "ebs"
  }
  owners      = ["amazon"]
  region      = "us-east-1"
  most_recent = true
}

# Define the new instance to be created and save it as amazon-ebs.ubuntu
source "amazon-ebs" "ubuntu" {
  source_ami       = data.amazon-ami.ubuntu.id
  region           = "us-east-1"
  instance_type    = "t3.large"
  ami_name         = "my_ubuntu_ami"
  force_deregister = true

  # Select VPC and subnet to build in
  vpc_id    = ""
  subnet_id = ""

  # Apply IAM Instance Profile to enable SSM
  iam_instance_profile = ""

  # Tell Packer to use SSH over SSM
  communicator  = "ssh"
  ssh_interface = "session_manager"
  ssh_username  = "ubuntu"
  ssh_timeout   = "10m" 
}

# Build AMI
build {
  sources = ["source.amazon-ebs.packer-build"]
  provisioner "shell" {
    inline = ["echo Connected via SSM at '${build.User}@${build.Host}:${build.Port}'"]
  }
}