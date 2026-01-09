terraform {
    backend "s3" {
        bucket = "my-remote-bucket-001"
        key = "terraform.tfstate"
        region = "ap-south-1"
        dynamodb_table = "tf-locks"
    }
}