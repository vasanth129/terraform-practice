provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "${terraform.workspace}-bucket-v11"
  
  tags = {
    Name = terraform.workspace
  }
}