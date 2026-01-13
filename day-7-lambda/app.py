def main(event, context):
    print("Welcome to Lambda function")

    return {
        "status" : 200,
        "body" : "Function Created by Terraform"
    }