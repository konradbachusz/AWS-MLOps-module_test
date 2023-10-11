variable "tags" {
  description = "Tags applied to your resources"
}

variable "model_name" {
  description = "Name of the Sagemaker model"
  type        = string
}


variable "mlops_s3_bucket" {}

