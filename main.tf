module "sagemaker" {
  source                          = "./modules/sagemaker"
  model_name                      = var.model_name
  sagemaker_image_repository_name = var.sagemaker_image_repository_name
  tags                            = var.tags
  sagemaker_execution_role_arn    = module.iam.sagemaker_role_arn
  endpoint_instance_type          = var.endpoint_instance_type
}

module "iam" {
  source = "./modules/iam"
  tags   = var.tags
}

module "s3" {
  source     = "./modules/s3"
  model_name = var.model_name
  tags       = var.tags
}

module "lambda" {
  source              = "./modules/lambda"
  model_name          = var.model_name
  filename            = "${path.module}/../lambda-ml-wrapper/ml-wrapper.zip"
  runtime             = "python3.9"
  lambda_timeout      = var.lambda_timeout
  model_api_endpoint  = var.model_api_endpoint
  role                = module.iam.sagemaker_role_arn
  model_endpoint_name = module.sagemaker.aws_sagemaker_endpoint.model_endpoint.name
  tags                = var.tags
}

