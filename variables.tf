##########################################
# Common
##########################################

variable "resource_naming_prefix" {
  description = "Naming prefix to be applied to all resources created by this module unless explicitly overriden."
  type        = string
}

variable "tags" {
  description = "Tags applied to your resources"
  default     = {}
}

##########################################
# Sagemaker
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

variable "sagemaker_instance_type" {
  description = "The Sagemaker notebook instance type to be created. Must be a valid EC2 instance type"
  default     = "ml.m4.xlarge"
  type        = string
}

variable "model_instance_count" {
  description = "The initial number of instances to run the Sagemaker model"
  type        = number
  default     = 1
}

##########################################
# S3
##########################################

variable "data_s3_bucket" {
  description = "The name of an S3 bucket within which training data is located."
  type        = string
}

variable "data_location_s3" {
  description = "The path to a file in the data S3 bucket within which training data is located. Should be in the format /<path>/<filename>. If the file is in the root of the bucket, this should be set to /<filename> only."
  type        = string
}

##########################################
# Glue
##########################################

variable "retraining_schedule" {
  description = "Cron expression for the model retraining frequency in the AWS format. See https://docs.aws.amazon.com/lambda/latest/dg/services-cloudwatchevents-expressions.html for details"
  type        = string
  default     = ""
}

variable "retrain_model_bool" {
  description = "Boolean to indicate if the retraining pipeline shoud be added"
  type        = bool
  default     = false
}

##########################################
# ECR
##########################################

variable "pycaret_ecr_name" {
  description = "Name of ECR repository that will be created and used to store the pycaret container image required for the model"
  type        = string
  default     = ""
}

##########################################
# Model arguments
##########################################

variable "model_target_variable" {
  description = "The dependent variable (or 'label') that the regression model aims to predict. This should be a column name in the dataset."
  type        = string
}

variable "algorithm_choice" {
  description = "Machine learning problem type e.g classification, regression, clustering, anomaly, time_series"
  type        = string
  validation {
    condition     = contains(["classification", "regression", "clustering", "anomaly", "time_series"], var.algorithm_choice)
    error_message = "Allowed values for algorithm_choice are \"classification\", \"regression\", \"clustering\",  \"anomaly\", or \"time_series\"."
  }
}

variable "tuning_metric" {
  description = "The metric user want to focus when tuning hyperparameter"
  type        = string
}
