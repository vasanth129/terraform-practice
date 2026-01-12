resource "aws_instance" "web-3" {
  ami = "ami-01ca13db604661046"
  instance_type = "t2.micro"
#   key_name = "ansible_demo"
  key_name = "kabali_access"

  tags = {
    Name = "web-3"
  }

  lifecycle {
    ignore_changes = [ tags ]
  }

}

import {
  to = aws_instance.web-3
  id = "i-0cb2b63be6fca9201"
}