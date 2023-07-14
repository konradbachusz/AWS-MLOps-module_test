

resource "aws_sagemaker_model" "my_model" {
  name               = var.model_name
  execution_role_arn = var.sagemaker_execution_role_arn

  primary_container {
    image = data.aws_sagemaker_prebuilt_ecr_image.image.registry_path
    #TODO: add model_data_url?
  }
  tags = var.tags
}

data "aws_sagemaker_prebuilt_ecr_image" "image" {
  repository_name = var.sagemaker_image_repository_name
}


resource "aws_sagemaker_endpoint_configuration" "endpoint_configuration" {
  name = "${var.model_name}-endpoint-config"

  production_variants {
    variant_name           = "variant-1" #TODO: Change?
    model_name             = var.model_name
    initial_instance_count = 1 #TODO: Change?
    instance_type          = var.endpoint_instance_type
  }

  tags = var.tags

}

resource "aws_sagemaker_endpoint" "model_endpoint" {
  name                 = "${var.model_name}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.endpoint_configuration.name
  tags                 = var.tags
}

#TODO: Add tags everywhere
#TODO Add API Gateway
