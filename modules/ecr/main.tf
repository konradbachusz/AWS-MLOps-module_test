resource "aws_kms_key" "ecr_encryption" {
  description         = "${var.pycaret_ecr_name}-encryption-key"
  enable_key_rotation = true
  tags                = var.tags
}

resource "aws_ecr_repository" "pycaret" {
  name                 = var.pycaret_ecr_name
  force_delete         = true
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr_encryption.arn
  }
  tags = var.tags
}
