data "terraform_remote_state" "vpc" {
  backend = "local"

  config {
    path = "../network/terraform.tfstate"
  }
}

resource "aws_key_pair" "key-public" {
  key_name = "swarm"
  public_key = "${file("key-pairs/swarm.pem.pub")}"
}

resource "aws_security_group" "swarm" {
  name = "${var.sg_name}"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

   ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
       "0.0.0.0/0"]
   } 

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "10.0.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}


# deploy swarm manager
resource "aws_instance" "swarm-manager" {
  count = "3"
  private_ip = "${element(var.managers_ips, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  subnet_id = "${element(data.terraform_remote_state.vpc.public_subnets, count.index)}"
  instance_type = "${var.type}"
  ami = "${var.ami}"
  key_name = "swarm"
  security_groups = [
    "${aws_security_group.swarm.id}"]
  associate_public_ip_address = true

  root_block_device {
    volume_size = "${var.size_so}"
    volume_type = "${var.type_disk_so}"
  }

  tags {
    Name = "${var.tag_manager}"
  }

  provisioner "file" {
    connection {
      user = "${var.ssh_user_name}"
      password = "${var.ssh_user_password}"
      private_key = "${file("key-pairs/swarm.pem")}"
    }

    source = "./key-pairs/swarm.pem"
    destination = "/home/ubuntu/swarm.pem"
  }

  provisioner "file" {
    connection {
      user = "${var.ssh_user_name}"
      password = "${var.ssh_user_password}"
      private_key = "${file("key-pairs/swarm.pem")}"
    }

    source = "./key-pairs/swarm.pem.pub"
    destination = "/home/ubuntu/swarm.pem.pub"
  }

  provisioner "file" {
    connection {
      user = "${var.ssh_user_name}"
      password = "${var.ssh_user_password}"
      private_key = "${file("key-pairs/swarm.pem")}"
    }

    source = "../ansible"
    destination = "/home/ubuntu/ansible"
  }

  provisioner "remote-exec" {
    connection {
      user = "${var.ssh_user_name}"
      password = "${var.ssh_user_password}"
      private_key = "${file("key-pairs/swarm.pem")}"
    }

    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install python-simplejson ansible -y",
      "sudo chmod 400 /home/ubuntu/swarm.pem*"]
  }

}

# deploy swarm worker
resource "aws_instance" "swarm-worker" {
  count = "${var.instanceWorker}"
  private_ip = "${element(var.workers_ips, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  subnet_id = "${element(data.terraform_remote_state.vpc.private_subnets, count.index)}"
  instance_type = "${var.type}"
  ami = "${var.ami}"
  key_name = "swarm"
  security_groups = [
    "${aws_security_group.swarm.id}"]
  associate_public_ip_address = false

  root_block_device {
    volume_size = "${var.size_so}"
    volume_type = "${var.type_disk_so}"
  }
  
  tags {
    Name = "${var.tag_worker}"
  }

  #provisioner "remote-exec" {
    #connection {
    #  user = "${var.ssh_user_name}"
    #  password = "${var.ssh_user_password}"
    #  private_key = "${file("key-pairs/swarm.pem")}"
    #}

#    inline = [
#      "sudo apt-get update -y",
#      "sudo apt-get install python-simplejson -y",]
#  }

}
