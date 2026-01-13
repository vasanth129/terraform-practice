resource "aws_lambda_function" "dev" {
  function_name = "my_lambda_fun"
  handler = "app.main"
  role = "arn:aws:iam::154061203679:role/lambda-adminAccess"
  runtime = "python3.12"
  timeout = 10
  s3_bucket = "lambda-bucket-012321321 "
  s3_key = "s3://lambda-bucket-012321321/app.zip"
}

