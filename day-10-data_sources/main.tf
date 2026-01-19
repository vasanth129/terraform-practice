resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = data.aws_ami.ami.id
  key_name = "kabali_access"

  vpc_security_group_ids = [ data.aws_security_group.by_tag.id ]
  subnet_id = data.aws_subnet.by_tag.id

}

data "aws_security_group" "by_tag" {
  filter {
    name = "tag:Name"
    values = ["pub-server-sg"]
  }
}

data "aws_subnet" "by_tag" {
  filter {
    name = "tag:Name"
    values = ["public-sb-1b-dft"]
  }
}

#fetches rhel 9
data "aws_ami" "ami" {
  owners           = ["309956199498"]

  filter {
    name   = "name"
    values = ["RHEL-9.6.0_HVM-20250910-x86_64-0-Hourly2-GP3"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
