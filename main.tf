# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}

resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_glue_job" "typical" {
  name     = "typical"
  role_arn = aws_iam_role.test_role.arn

  command {
    script_location = "s3://pythoncalculator/calculator.py"
  }
}
