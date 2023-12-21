##########################################
# Naming and Tagging
##########################################

variable "model_name" {
  description = "Name of the Sagemaker model"
  type        = string
  default     = ""
}
variable "endpoint_name" {
  description = "Name of the Sagemaker endpoint for prediction"
  type        = string
  default     = ""
}
variable "tags" {
  description = "Tags applied to your resources"
  default     = {}
}

#########################################
# Sagemaker
#########################################

# Training
variable "model_target_variable" {
  description = "The dependent variable (or 'label') that the regression model aims to predict. This should be a column name in the dataset."
  type        = string
}
variable "algorithm_choice" {
  description = "Machine learning problem type e.g classification, regression, clustering, anomaly, time_series"
  type        = string
}
variable "tuning_metric" {
  description = "The metric user want to focus when tuning hyperparameter"
  type        = string
}

# Notebook
variable "sagemaker_instance_type" {
  description = "The Sagemaker notebook instance type to be created. Must be a valid EC2 instance type"
  type        = string
}

# Model
variable "model_instance_count" {
  description = "The initial number of instances to run the Sagemaker model"
  type        = number
}
variable "ecr_repo_uri" {
  description = "The URI of the ECR repository containing the pycaret image, including tag."
  type        = string
}

#########################################
# S3
#########################################

# Data bucket
variable "data_s3_bucket" {
  description = "The name of an S3 bucket within which training data is located."
  type        = string
}
variable "data_location_s3" {
  description = "The path to a file in the data S3 bucket within which training data is located. Should be in the format /<path>/<filename>. If the data is in the root of the bucket, this should be set to /<filename> only."
  type        = string
}
variable "data_bucket_key_arn" {
  description = "The ARN of the KMS key using which data is encrypted in S3."
  type        = string
}

# Model bucket
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
