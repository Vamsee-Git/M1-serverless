output "add_data_lambda_name" {
  value = aws_lambda_function.add_data.function_name
}

output "get_data_lambda_name" {
  value = aws_lambda_function.get_data.function_name
}
