resource "aws_s3_bucket" "model_bucket" {
  bucket        = "${var.model_name}-model"
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_object" "model_artifact" {
  bucket = aws_s3_bucket.model_bucket.bucket
  key    = "model.tar.gz"
  source = "model.tar.gz"
  tags   = var.tags
}
