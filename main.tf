provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "images" {
  bucket = "creative-network-images"

  versioning {
    enabled = false
  }

  tags {
    Name = "creative-network-images"
    Environment = "dev"
  }
}

resource "aws_api_gateway_rest_api" "resizer" {
  name        = "image-resizer"
  description = "Creative network image resizer"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "empty-function.zip"
  source_code_hash = "${base64sha256(file("empty-function.zip"))}"
  function_name    = "image-resizer"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "index.handler"
  runtime          = "nodejs6.10"
}
