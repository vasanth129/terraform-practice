resource "aws_instance" "web" {
  ami = "ami-01ca13db604661046"
  instance_type = "t2.micro"

  tags = {
    Name = "web-instance"
  }
}