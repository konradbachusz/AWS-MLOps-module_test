output "retraining_job" {
  description = "The Glue retraining job Terraform object."
  value       = aws_glue_job.retraining_glue_job
}

output "retraining_role" {
  description = "The Glue retraining job IAM role Terraform object."
  value       = aws_iam_role.iam_for_glue_retraining_job_role
}
