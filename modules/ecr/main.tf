resource "aws_ecr_repository" "mlops_pycaret_repo" {
  name         = var.pycaret_ecr_name
  force_delete = true
}
