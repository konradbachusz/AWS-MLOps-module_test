output "notebook_instance" {
  description = "Sagemaker notebook instance Terraform object"
  value       = aws_sagemaker_notebook_instance.notebook
}

output "sagemaker_role" {
  description = "Sagemaker IAM role Terraform object"
  value       = aws_iam_role.sagemaker
}
