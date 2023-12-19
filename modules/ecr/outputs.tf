output "repository" {
  description = "The ECR repository Terraform object."
  value       = aws_ecr_repository.mlops_pycaret_repo
}

output "encryption_key" {
  description = "The ECR repository encryption KMS key Terraform object."
  value       = aws_kms_key.ecr_kms
}
