#########################################
# Sagemaker
#########################################

variable "sagemaker_execution_role_arn" {}

variable "model_target_variable" {}

variable "algorithm_choice" {}

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

# Naming and Tagging

variable "endpoint_name" {}

variable "model_name" {}

variable "tags" {}


# Training data bucket
variable "data_s3_bucket" {
  description = "The name of an S3 bucket within which training data is located."
  type        = string
}
variable "data_bucket_key_arn" {
  description = "The ARN of the KMS key using which data is encrypted in S3."
  type        = string
}

# Sagemaker model location
variable "model_s3_bucket" {
  description = "The name of an S3 bucket within which training data is located."
  type        = string
}
variable "model_bucket_key_arn" {
  description = "The ARN of the KMS key using which data is encrypted in S3."
  type        = string
}

# Config Bucket
variable "config_s3_bucket" {
  description = "The name of an S3 bucket within which glue scripts should be stored."
  type        = string
}
variable "config_bucket_key_arn" {
  description = "The ARN of the KMS key using which glue scripts are encrypted in S3."
  type        = string
}
