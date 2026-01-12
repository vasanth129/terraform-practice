resource "aws_instance" "web-2" {
  ami = "ami-01ca13db604661046"
  instance_type = "t2.micro"
#   key_name = "ansible_demo"
  key_name = "kabali_access"

  tags = {
    Name = "web-2"
  }

  lifecycle {
    prevent_destroy = true
  }

}