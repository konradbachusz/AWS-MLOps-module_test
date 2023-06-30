output "sagemaker_role_arn" {
  description = "Sagemaker role ARN"
  value       = aws_iam_role.sagemaker_role.arn
}
