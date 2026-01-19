resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "ami-01ca13db604661046"
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
