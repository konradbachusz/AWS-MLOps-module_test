output "config_bucket_id" {
  value = aws_s3_bucket.config_bucket_id.id
}

output "mlops_s3_bucket"{
  value = aws_s3_bucket.s3_mlops_feature_engineering.id
}