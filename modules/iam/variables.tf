variable "tags" {
  description = "Tags applied to your resources"
}
variable "model_name" {
  description = "Name of the Sagemaker model"
  type        = string
}

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

