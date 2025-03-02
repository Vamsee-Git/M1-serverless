resource "aws_api_gateway_rest_api" "lambda_api" {
  name        = var.api_gateway_name
  description = "API for triggering Lambda functions"
}

resource "aws_api_gateway_resource" "dynamodb" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  parent_id   = aws_api_gateway_rest_api.example_api.root_resource_id
  path_part   = "dynamodb"
}

resource "aws_api_gateway_method" "get_data" {
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  resource_id   = aws_api_gateway_resource.dynamodb.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  resource_id = aws_api_gateway_resource.dynamodb.id
  http_method = aws_api_gateway_method.get_data.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri  = aws_lambda_function.get_data.invoke_arn
}
