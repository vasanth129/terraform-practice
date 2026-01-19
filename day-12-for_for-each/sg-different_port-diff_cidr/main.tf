resource "aws_instance" "web" {
  ami                                  = "ami-01ca13db604661046"
  instance_type                        = "t2.micro"
  key_name                             = "kabali_access"
  tags = {
    Name = "web-instance"
  }
}

variable "allowed_ports" {
  type = map(string)
  default = {
    22    = "203.0.113.0/24"    # SSH (Restrict to office IP)
    80    = "0.0.0.0/0"         # HTTP (Public)
    443   = "0.0.0.0/0"         # HTTPS (Public)
    8080  = "10.0.0.0/16"       # Internal App (Restrict to VPC)
    9000  = "192.168.1.0/24"    # SonarQube/Jenkins (Restrict to VPN)
  }
}

resource "aws_security_group" "sg" {
  vpc_id = "vpc-0aa3c91f8a8125c44"

  egress {
        protocol = "-1"
        to_port = 0
        from_port = 0
        cidr_blocks = [
            "0.0.0.0/0"
        ]

    }

  dynamic "ingress"{ 
    for_each = var.allowed_ports
    
    content {
        to_port = ingress.key
        from_port = ingress.key
        protocol = "tcp"
        cidr_blocks = [ingress.value]
    }

  }
}