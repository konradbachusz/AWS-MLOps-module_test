output "model" {
  value       = module.sagemaker.model
  description = "Outputs the machine learning model resource"
}

output "model_endpoint" {
  value       = module.sagemaker.model_endpoint
  description = "Outputs the machine learning model endpoint resource"
}