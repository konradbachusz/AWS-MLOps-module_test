#########################################
# Sagemaker
#########################################

variable "model_name" {}

variable "sagemaker_image_repository_name" {}

variable "endpoint_instance_type" {}

variable "vpc_id" {}

variable "subnet_ids" {}

variable "sagemaker_execution_role_arn" {}

variable "tags" {}

variable "data_location_s3" {}

variable "model_target_variable" {}

variable "s3_bucket_id" {}