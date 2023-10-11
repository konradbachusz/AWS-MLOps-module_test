output "config_bucket_id" {
  value = aws_s3_bucket.model_buckets[1].id 
}

output "mlops_s3_bucket_id"{
  value = aws_s3_bucket.model_buckets[2].id 
}