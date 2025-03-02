module "dynamodb" {
  source = "./modules/dynamodb"
}

module "lambda" {
  source = "./modules/lambda"
  dynamodb_table_name = module.dynamodb.table_name
}

module "apigateway" {
  source = "./modules/apigateway"
  lambda_function_name = module.lambda.get_data_lambda_name
}
