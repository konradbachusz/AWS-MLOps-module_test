#Creating an S3 bucket to heep the trained model
resource "aws_s3_bucket" "model_bucket" {
  bucket        = "${var.model_name}-model"
  force_destroy = true
  tags          = var.tags
}

#Creating an S3 bucket to hold the any helper scripts
resource "aws_s3_bucket" "config_bucket" {
  bucket        = "${var.model_name}-config-bucket"
  tags          = var.tags
  force_destroy = true
}