output "model" {
  value = aws_sagemaker_model.my_model
}

output "model_endpoint" {
  value = aws_sagemaker_endpoint.model_endpoint
}