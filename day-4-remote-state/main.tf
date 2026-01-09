resource "aws_instance" "name" {
    ami = var.ami_id
    key_name = var.key_name
    instance_type = var.instance_type
}

resource "aws_s3_bucket" "name" {
    bucket = "kabali-remote-state-file"
    region = "ap-south-1"
    tags = {
        "Name" = "kabali-state-file"
        "Env" = "Dev"
    }
}