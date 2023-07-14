data "local_file" "lambda_zip" {
  filename = var.lambda_filename
}

resource "aws_lambda_function" "model_endpoint_lambda" {
  filename         = data.local_file.lambda_zip.filename
  function_name    = "${var.model_name}-model-endpoint-lambda"
  role             = aws_iam_role.sagemaker_role.arn
  handler          = var.lambda_handler #TODO check how we define "tfl_lambda.lambda_function.lambda_handler"
  timeout          = var.lambda_timeout
  source_code_hash = filebase64sha256(data.local_file.lambda_zip.filename)

  runtime = var.runtime
  environment {
    variables = {
      ENDPOINT_NAME = "streaming-data-platform-endpoint"
      API_ENDPOINT  = var.alb_dns
    }
  }

  tags = var.tags
}

#TODO add Python code and Lambda zip stuff