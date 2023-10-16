output "ecr_name" {
    description = "The ECR name"
  value = try(aws_ecr_repository.mlops_pycaret_repo.name, "")
}
