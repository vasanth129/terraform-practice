terraform {
    backend "s3" {
        bucket = "kabali-remote-state-file"
        key = "terraform.tfstate"
        region = "ap-south-1"
        dynamodb_table = "tf-locks"
    }
}