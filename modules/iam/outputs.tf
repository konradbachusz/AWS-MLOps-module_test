output "sagemaker_role" {
  description = "Sagemaker IAM role Terraform object"
  value       = aws_iam_role.sagemaker_role
}
