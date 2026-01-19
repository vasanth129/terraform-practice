resource "aws_instance" "web_instance" {
  instance_type = "t2.micro"
  ami = "ami-01ca13db604661046"
  key_name = aws_key_pair.my_key.key_name

  depends_on = [ aws_key_pair.my_key ]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }

  provisioner "local-exec" {
    command = "touch file10"
  }

  provisioner "remote-exec" {
    inline = [ 
        "touch file100",
        "echo this is bhavana from ec2 instance > file100 "
     ]
  }

  provisioner "file" {
    source = "./file1"
    destination = "file1"
  }
  
}

resource "aws_key_pair" "my_key" {
  key_name = "asus_key"
  public_key = file("~/.ssh/id_rsa.pub")
}
