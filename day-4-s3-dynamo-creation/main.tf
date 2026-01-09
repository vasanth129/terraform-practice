resource "aws_s3_bucket" "name" {
    bucket = "kabali-remote-state-file"
    region = "ap-south-1"
    tags = {
        "Name" = "myownbucket"
        "Env" = "Dev"
    }
}

resource "aws_dynamodb_table" "name" {
    name = "tf-locks"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"

    attribute {
      name = "LockID"
      type = "S" 
    }

    tags = {
        Name = "terraform-state-lock"
    }
}