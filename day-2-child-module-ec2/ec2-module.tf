resource "aws_instance" "web" {
  ami = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type

  tags = {
    Name = var.name
  }
}

output "instance_id" {
  value = aws_instance.web.id
}