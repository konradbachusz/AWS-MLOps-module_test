module "sagemaker" {
  source                          = "./modules/sagemaker"
  model_name                      = var.model_name
  sagemaker_image_repository_name = var.sagemaker_image_repository_name
}