resource "aws_instance" "name" {
    ami = var.ami_id
    key_name = var.key_name
    instance_type = var.instance_type
    tags = {
        "Name" = "Dev"
    }
}

resource "aws_s3_bucket" "name" {
    bucket = "myownbucket-0000123"
    region = "ap-south-1"
    tags = {
        "Name" = "myownbucket"
        "Env" = "Dev"
    }
}