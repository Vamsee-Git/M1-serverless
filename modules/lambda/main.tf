resource "aws_iam_role" "lambda_exec" {
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_dynamo_policy" {
  name        = "lambda_dynamo_policy"
  description = "Policy for Lambda functions to interact with DynamoDB"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Effect   = "Allow"
        Resource = aws_dynamodb_table.example.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  policy_arn = aws_iam_policy.lambda_dynamo_policy.arn
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_lambda_function" "add_data" {
  function_name = "add_data_lambda"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.handler"
  filename      = "add_data.zip"

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}

resource "aws_lambda_function" "get_data" {
  function_name = "get_data_lambda"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.handler"
  filename      = "get_data.zip"

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
    }
  }
}
