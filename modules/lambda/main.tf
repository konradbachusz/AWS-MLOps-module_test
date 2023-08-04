data "local_file" "lambda_zip" {
  filename = var.filename
}

resource "aws_lambda_function" "model_endpoint_lambda" {
  filename         = var.filename
  function_name    = "${var.model_name}-model-endpoint-lambda"
  role             = var.role
  handler          = "ml_wrapper.lambda_function.lambda_handler"
  timeout          = var.lambda_timeout
  source_code_hash = filebase64sha256(data.local_file.lambda_zip.filename)

  runtime = var.runtime
  environment {
    variables = {
      ENDPOINT_NAME = var.model_endpoint_name
      API_ENDPOINT  = var.model_api_endpoint #TODO create this in terraform
    }
  }

  tags = var.tags
}

