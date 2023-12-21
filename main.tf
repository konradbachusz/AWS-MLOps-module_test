module "s3" {
  source                 = "./modules/s3"
  resource_naming_prefix = var.resource_naming_prefix
  tags                   = var.tags
}

module "sagemaker" {
  source                       = "./modules/sagemaker"
  tags                         = var.tags
  sagemaker_execution_role_arn = module.iam.sagemaker_role.arn
  model_target_variable        = var.model_target_variable
  algorithm_choice             = var.algorithm_choice
  tuning_metric                = var.tuning_metric
  endpoint_name                = local.endpoint_name
  model_name                   = local.model_name
  sagemaker_instance_type      = var.sagemaker_instance_type
  model_instance_count         = var.model_instance_count
  ecr_repo_uri                 = "${module.ecr.repository.repository_url}:latest"
  config_s3_bucket             = module.s3.config_bucket.id
  config_bucket_key_arn        = module.s3.encryption_key.arn
  data_s3_bucket               = var.data_s3_bucket
  data_bucket_key_arn          = var.data_s3_bucket_encryption_key_arn
  data_location_s3             = var.data_location_s3
  model_s3_bucket              = module.s3.model_bucket.id
  model_bucket_key_arn         = module.s3.encryption_key.arn
}

module "retraining_job" {
  count                  = var.retrain_model_bool ? 1 : 0
  source                 = "./modules/glue"
  resource_naming_prefix = var.resource_naming_prefix
  tags                   = var.tags
  config_s3_bucket       = module.s3.config_bucket.id
  config_bucket_key_arn  = module.s3.encryption_key.arn
  data_s3_bucket         = var.data_s3_bucket
  data_bucket_key_arn    = var.data_s3_bucket_encryption_key_arn
  data_location_s3       = var.data_location_s3
  retraining_schedule    = var.retraining_schedule
}


module "ecr" {
  source           = "./modules/ecr"
  pycaret_ecr_name = local.pycaret_ecr_name
}
