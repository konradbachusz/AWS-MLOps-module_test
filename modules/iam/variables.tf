variable "tags" {
  description = "Tags applied to your resources"
}
variable "model_name" {}

# Training data location
variable "data_s3_bucket" {
  description = "The name of an S3 bucket within which training data is located."
  type        = string
}
variable "data_location_s3" {
  description = "The path to a file in the data S3 bucket within which training data is located. Should be in the format /<path>/<filename>. If the data is in the root of the bucket, this should be set to /<filename> only."
  type        = string
}

