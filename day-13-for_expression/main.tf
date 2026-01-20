provider "aws" {
 region = "ap-south-1" 
}

variable "subnet_cidr" {
  type = list(string)
  default = [ "192.168.0.0/28", "192.168.0.16/28", "192.168.0.32/28" ]
}

output "subnet_names" {
  value = [
    for cidr in var.subnet_cidr :
    "subnet-${replace(cidr, "/", "-")}"
  ]
}

output "cidr_to_name" {
  value = {
    for cidr in var.subnet_cidr :
    cidr => "subnet-${replace(cidr, "/", "-")}"
  }
}


