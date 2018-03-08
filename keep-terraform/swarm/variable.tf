variable "instanceWorker" {
	default = "3"
}

variable "ami" {
	default = "ami-7c412f13"
#	default = "ami-cd0f5cb6"
}

variable "managers_ips" {
  type = "list"
  default = ["10.0.7.220", "10.0.8.221", "10.0.7.222"]
}

variable "workers_ips" {
  type = "list"
  default = ["10.0.9.220", "10.0.10.221", "10.0.9.222"]
}

variable "azs" {
  type = "list"
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "region" {
  default = "eu-central-1"
}

variable "type" {
  default = "t2.micro"
}

variable "sg_name" {
  default = "swarm"
}

variable "type_disk_so" {
        default = "gp2"
}

variable "size_so" {
        default = "20"
}

variable "type_disk_storage" {
        default = "gp2"
}

variable "size_storage" {
        default = "20"
}

variable "tag_manager" {
  default = "swarm_manager"
}

variable "tag_worker" {
  default = "swarm_worker"
}

variable "ssh_user_name" {
  default = "ubuntu"
}

variable "ssh_user_password" {
  default = "renanm123"
}
