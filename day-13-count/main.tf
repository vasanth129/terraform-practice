provider "aws" {
 region = "ap-south-1" 
}

# creating instances with count
# resource "aws_instance" "server" {
#   count = 4 # create four similar EC2 instances

#   ami           = "ami-01ca13db604661046"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "Server ${count.index}"
#   }
# }

resource "aws_vpc" "dev" {
  cidr_block = "192.168.0.0/26"
  tags = {
    Name = "dev_vpc"
  }
}

variable "subnet_cidr" {
  type = list(string)
  default = [ "192.168.0.0/28", "192.168.0.16/28", "192.168.0.32/28" ]
}

#creating subnets with count
resource "aws_subnet" "dev" {
  count = length(var.subnet_cidr)
  vpc_id = aws_vpc.dev.id
  availability_zone = "ap-south-1a"
  cidr_block = var.subnet_cidr[count.index]

  tags = {
    Name = "subnet ${count.index}"
  }
}

output "first_id" {
  value = aws_subnet.dev[0].id
}

output "all_ids" {
  value = aws_subnet.dev[*].id
}





