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

resource "aws_s3_bucket" "lambda_functions" {
  bucket = "creative-network-lambda"

  versioning {
    enabled = false
  }

  tags {
    Name = "creative-network-lambda"
    Environment = "dev"
  }
}

resource "aws_api_gateway_rest_api" "resizer" {
  name        = "image-resizer"
  description = "Creative network image resizer"
}
