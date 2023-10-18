output "ecr_repo_name" {
  description = "The ECR name"
  value       = try(module.ecr.ecr_name, "")
}
