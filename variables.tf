variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  default     = "data-table"
}

variable "lambda_role_name" {
  description = "The IAM role name for Lambda functions"
  default     = "lambda_exec_role"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  default     = "lambda-api"
}
