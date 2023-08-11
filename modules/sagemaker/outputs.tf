output "aws_sagemaker_endpoint_name" {
  description = "Sagemaker aws_sagemaker_endpoint"
  value       = aws_sagemaker_endpoint.model_endpoint.name
}
