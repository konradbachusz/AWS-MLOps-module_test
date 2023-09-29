module "sagemaker" {
  source                          = "./modules/sagemaker"
  model_name                      = var.model_name
  sagemaker_image_repository_name = var.sagemaker_image_repository_name
  tags                            = var.tags
  sagemaker_execution_role_arn    = module.iam.sagemaker_role_arn
  endpoint_instance_type          = var.endpoint_instance_type
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
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

