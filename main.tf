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
