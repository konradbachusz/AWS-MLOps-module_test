module "s3" {
  source          = "./modules/s3"
  model_name      = var.model_name
  tags            = var.tags
  mlops_s3_bucket = var.mlops_s3_bucket
}

module "sagemaker" {
  source                          = "./modules/sagemaker"
  model_name                      = var.model_name
  sagemaker_image_repository_name = var.sagemaker_image_repository_name
  tags                            = var.tags
  sagemaker_execution_role_arn    = module.iam.sagemaker_role_arn
  endpoint_instance_type          = var.endpoint_instance_type
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  model_target                    = var.model_target
  model_features                  = var.model_features
  s3_bucket                       = var.s3_bucket
  mlops_s3_bucket                 = var.mlops_s3_bucket
  s3_obj_key                      = var.s3_obj_key
  depends_on                      = [module.s3]
}


module "iam" {
  source     = "./modules/iam"
  tags       = var.tags
  region     = var.region
  account_id = var.account_id
}


module "retraining_job" {
  count                   = var.retrain_model_bool ? 1 : 0
  source                  = "./modules/glue"
  model_name              = var.model_name
  tags                    = var.tags
  config_bucket_id        = module.s3.config_bucket_id
  data_source_bucket_name = var.data_source_bucket_name
  retraining_schedule     = var.retraining_schedule
}

