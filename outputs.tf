output "dynamodb_table_name" {
  value = aws_dynamodb_table.data_table.name
}

output "api_gateway_url" {
  value = aws_api_gateway_rest_api.lambda_api.invoke_url
}
