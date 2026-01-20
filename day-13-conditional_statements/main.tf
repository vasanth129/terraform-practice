provider "aws" {
 region = "ap-south-1" 
}

# if statement using count
variable "enable_database_vpc" {
  type = bool
  default = false
}

resource "aws_vpc" "database_vpc" {
  cidr_block = "10.0.0.0/26"
  count = var.enable_database_vpc ? 1 : 0
}


#if else condition with count
variable "enable_public" {
  type = bool
  default = false
}

resource "aws_subnet" "public" {
  cidr_block = "10.0.0.0/28"
  vpc_id = "vpc-0aa3c91f8a8125c44"
  count = var.enable_public ? 1 : 0
}

resource "aws_subnet" "private" {
  cidr_block = "10.0.1.0/28"
  vpc_id = "vpc-0aa3c91f8a8125c44"
  count = var.enable_public ? 0 : 1
}