resource "aws_vpc" "dev" {
  cidr_block = "192.168.0.0/26"
  tags = {
    Name = "dev_vpc"
  }
}

resource "aws_subnet" "dev" {
  vpc_id = aws_vpc.dev.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.0.0/28"

  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id

  tags ={
    Name = "dev_iGW"
  }
}

resource "aws_route_table" "dev" {
  vpc_id = aws_vpc.dev.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev.id
    }

  tags = {
    Name = "dev-public_RT"
  }
}

resource "aws_route_table_association" "dev" {
    route_table_id = aws_route_table.dev.id
    subnet_id = aws_subnet.dev.id
}

resource "aws_security_group" "dev" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "dev-ec2-sg"
  }

}

resource "aws_vpc_security_group_ingress_rule" "dev" {
  security_group_id = aws_security_group.dev.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  to_port = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "dev" {
  security_group_id = aws_security_group.dev.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol       = "-1"

}

resource "aws_instance" "dev" {
  subnet_id = aws_subnet.dev.id
  instance_type = "t2.micro"
  key_name = "kabali_access"
  ami = "ami-01ca13db604661046"
  vpc_security_group_ids = [aws_security_group.dev.id]
  associate_public_ip_address = true

  tags = {
    Name = "dev-instance"
  }
}
