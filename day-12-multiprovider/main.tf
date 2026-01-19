provider "aws" {
  region = "us-east-1"
  alias = "provider1"
}


provider "aws" {
    region = "ap-south-1"
    alias = "provider2"
  
}
resource "aws_s3_bucket" "provider-1" {
    bucket = "fghjrtyucvhcv"
    provider = aws.provider2   # s3 bucket will create into "ap-south-1"
  
}

resource "aws_instance" "name" {
    ami = "ami-085ad6ae776d8f09c"
    instance_type = "t2.micro"
    key_name = "ec2test"
    availability_zone = "us-east-1a"
    tags = {
      Name = "dev"
    }
   
  
}
