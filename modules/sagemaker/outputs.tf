output "notebook_instance" {
  description = "Sagemaker notebook instance Terraform object"
  value       = aws_sagemaker_notebook_instance.notebook_instance
}
