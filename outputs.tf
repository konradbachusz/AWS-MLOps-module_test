output "sagemaker_model_name" {
  description = "The name of the model"
  value       = module.sagemaker.model_name
}

output "ecr_name" {
  description = "the name of the ecr repo"
  value = module.ecr.ecr_name
}