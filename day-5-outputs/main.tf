resource "aws_instance" "dev" {
  ami = "ami-0ced6a024bb18ff2e"
  key_name = "kabali_access"
  instance_type = "t2.micro"
  tags = {
    Name = "dev"
  }
}

output "public_ip" {
  value = aws_instance.dev.public_ip
}