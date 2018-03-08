variable "name" {
  default = "renanmorilha"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = "list"
  default     = ["10.0.7.0/24", "10.0.8.0/24"]
}

variable "private_subnets" {
  type = "list"
  default     =  ["10.0.9.0/24" , "10.0.10.0/24"]
}

variable "azs" {
  type = "list"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "enable_dns_hostnames" {
  default     = true
}

variable "enable_dns_support" {
  default     = true
}

variable "enable_nat_gateway" {
  default     = true
}

// Enable Public IP on EC2 startup
variable "map_public_ip_on_launch" {
  default     = true
}

variable "private_propagating_vgws" {
  type = "list"
  default     = []
}

variable "public_propagating_vgws" {
  type = "list"
  default     = []
}

variable "tags" {
  default     = {}
}
