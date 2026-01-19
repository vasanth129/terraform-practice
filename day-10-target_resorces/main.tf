resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "ami-01ca13db604661046"
  key_name = "kabali_access"

  tags = {
    Name = "web-instance"
  }
}

resource "aws_instance" "app" {
  instance_type = "t2.micro"
  ami = "ami-01ca13db604661046"
  key_name = "kabali_access"

  tags = {
    Name = "app-instance"
  }
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "kabali-remote-bucket"
}