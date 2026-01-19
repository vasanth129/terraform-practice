resource "aws_instance" "web-server" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key.key_name
  iam_instance_profile = data.aws_iam_role.ec2_role.name

  depends_on = [ aws_key_pair.my_key ]

}

data "aws_iam_role" "ec2_role" {
  name = "ec2-role"
}

resource "null_resource" "setup_and_upload" {

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host = aws_instance.web-server.public_ip

  }
  
  provisioner "remote-exec" {
    inline = [ 
        "sudo yum install httpd -y",
        "sudo yum install unzip -y",
        "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
        "unzip awscliv2.zip",
        "sudo ./aws/install",
        "echo aws cli installed",
        "sudo systemctl enable httpd --now",
        "sudo touch /var/www/html/index.html",
        "echo '<h1>Welcome to the Web Server created using Terraform</h1>' | sudo tee /var/www/html/index.html",
        "aws s3 cp /var/www/html/index.html s3://kabali-static-website-1/",
        "echo File updated to s3."
     ]
  }

  triggers = {
    instance_id = aws_instance.web-server.id
  }

  depends_on = [ aws_instance.web-server ]

}

#create key_pair from terraform
resource "aws_key_pair" "my_key" {
  public_key = file("~/.ssh/id_rsa.pub")
  key_name = "asus_key"
}

#fetch rhel 9 ami
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

# output "ami_id" {
#   value = data.aws_ami.ami.id
# }

# output "ec2_role" {
#   value = data.aws_iam_role.ec2_role.arn
# }