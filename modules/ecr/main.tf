resource "aws_ecr_repository" "mlops_pycaret_repo" {
  name         = var.pycaret_ecr_name
  force_delete = true
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
