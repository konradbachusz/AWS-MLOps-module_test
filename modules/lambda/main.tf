data "archive_file" "ml_wrapper_lambda" {
  type        = "zip"
  source_file = "${path.module}/../lambda-ml-wrapper/ml_wrapper/lambda_function.py"
  output_path = "ml-wrapper.zip"
}

resource "aws_lambda_function" "model_endpoint_lambda" {
  function_name    = "${var.model_name}-model-endpoint-lambda"
  role             = var.role
  handler          = "ml_wrapper.lambda_function.lambda_handler"
  timeout          = var.lambda_timeout
  filename         = data.archive_file.ml_wrapper_lambda.output_path
  source_code_hash = data.archive_file.ml_wrapper_lambda.output_base64sha256

  runtime = var.runtime
  environment {
    variables = {
      ENDPOINT_NAME = "${var.model_name}-endpoint"
      API_ENDPOINT  = var.model_api_endpoint #TODO create this in terraform
    }
  }

  tags = var.tags
}

