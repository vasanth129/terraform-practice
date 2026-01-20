provider "aws" {
 region = "ap-south-1" 
}

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

#creating subnets with for_each
resource "aws_subnet" "dev" {
  for_each = toset(var.subnet_cidr)
  vpc_id = aws_vpc.dev.id
  availability_zone = "ap-south-1a"
  cidr_block = each.value

  tags = {
    Name = "subnet-dev-${each.key}"
  }
}

output "dev-subnets" {
  value = values(aws_subnet.dev)[*].id
}




