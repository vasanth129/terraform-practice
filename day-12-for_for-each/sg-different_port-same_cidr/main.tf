resource "aws_instance" "web" {
  ami                                  = "ami-01ca13db604661046"
  instance_type                        = "t2.micro"
  key_name                             = "kabali_access"
  tags = {
    Name = "web-instance"
  }
}

variable "sg_ports" {
  type = list(number)
  default = [ 22, 3306, 443, 8080, 8000 ]
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

  ingress = [
    for port in var.sg_ports : {
        protocol = "-1"
        to_port = port
        from_port = port
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self = false
        description = "ingress rules"
    }
  ]

}