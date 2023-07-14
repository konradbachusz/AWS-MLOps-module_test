resource "aws_s3_bucket" "model_bucket" {
  bucket        = "${var.model_name}-model"
  force_destroy = true
  tags          = var.tags
}