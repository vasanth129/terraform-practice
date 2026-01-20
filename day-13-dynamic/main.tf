provider "aws" {
 region = "ap-south-1" 
}

variable "custom_ports" {
  type = map(string)
  default = {
    "22" : "192.168.1.12/32",
    "80" : "0.0.0.0/0",
    "443" : "0.0.0.0/0",
    "3306" : "192.168.0.0/26",
  }
}

resource "aws_security_group" "sg" {
  vpc_id = "vpc-0aa3c91f8a8125c44"

  dynamic "ingress" {
    for_each = var.custom_ports

    content {
      protocol = "tcp"
      from_port = ingress.key
      to_port = ingress.key
      cidr_blocks = [ ingress.value ]
    }
  }
  

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}




