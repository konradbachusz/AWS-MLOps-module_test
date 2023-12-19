#########################################
# Sagemaker
#########################################

variable "sagemaker_execution_role_arn" {}

variable "tags" {}

variable "model_target_variable" {}

variable "config_bucket_id" {}

variable "algorithm_choice" {}

variable "endpoint_name" {}

variable "model_name" {}

variable "sagemaker_instance_type" {}

variable "model_instance_count" {}

variable "ecr_repo_uri" {}

variable "tuning_metric" {}

# Training data location
variable "data_s3_bucket" {
  description = "The name of an S3 bucket within which training data is located."
  type        = string
}
variable "data_location_s3" {
  description = "The path to a file in the data S3 bucket within which training data is located. Should be in the format /<path>/<filename>. If the data is in the root of the bucket, this should be set to /<filename> only."
  type        = string
}
