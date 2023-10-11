#Creating an S3 bucket to heep the trained model

locals {
  file_path = "${path.module}/../../mlops_ml_models"
  files_to_upload = concat(
    tolist(fileset(local.file_path, "*.ipynb")),
    tolist(fileset(local.file_path, "*.py"))
  )
  bucket_names = tolist(["${var.model_name}-model", "${var.model_name}-config-bucket", var.mlops_s3_bucket])
}


resource "aws_kms_key" "s3_kms_key" {
  enable_key_rotation = true
}


resource "aws_s3_bucket" "model_buckets" {
  count  = length(local.bucket_names)
  bucket = local.bucket_names[count.index]
  server_side_encryption_configuration {
     rule {
       apply_server_side_encryption_by_default {
         kms_master_key_id = aws_kms_key.s3_kms_key.arn
         sse_algorithm     = "aws:kms"
       }
     }
   }
}



resource "aws_s3_bucket_public_access_block" "s3_access_block" {
  count = length(aws_s3_bucket.model_buckets)

  bucket = aws_s3_bucket.model_buckets[count.index].id
  block_public_acls = true
  block_public_policy = true 
  ignore_public_acls = true
  restrict_public_buckets = true
}




resource "aws_s3_bucket_object" "s3_files" {
  for_each = toset(local.files_to_upload)
  # count  = aws_s3_bucket.model_buckets[2].id == null ? 0 : 2
  bucket = aws_s3_bucket.model_buckets[2].id 
  key      = each.value
  source   = "${local.file_path}/${each.value}"
  etag     = filemd5("${local.file_path}/${each.value}")
  tags     = var.tags
}