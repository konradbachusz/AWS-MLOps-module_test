module "iam" {
  source = "../../modules/iam"
}


resource "aws_sagemaker_model" "my_model" {
  name               = var.model_name
  execution_role_arn = module.iam.sagemaker_role_arn

  primary_container {
    image = data.aws_sagemaker_prebuilt_ecr_image.image.registry_path
  }
}

data "aws_sagemaker_prebuilt_ecr_image" "image" {
  repository_name = var.sagemaker_image_repository_name
}