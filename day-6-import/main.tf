import {
  to = aws_instance.web
  id = "i-0bb69b7ab1adcd4a9"
}

resource "aws_instance" "web" {
  ami                                  = "ami-01ca13db604661046"
  instance_type                        = "t2.micro"
  key_name                             = "kabali_access"
  security_groups                      = ["pub-server-sg"]
  subnet_id                            = "subnet-0fea1a116522d79d9"
  tags = {
    Name = "web-instance"
  }
}