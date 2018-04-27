variable "aws_region" {
  default = "eu-central-1"
} # London

provider "aws" {
  region     = "${var.aws_region}"
  access_key = ""
  secret_key = ""
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "image_id" {
  value = "${data.aws_ami.ubuntu.id}"
}
