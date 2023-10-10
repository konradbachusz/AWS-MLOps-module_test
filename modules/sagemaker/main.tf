

# resource "aws_sagemaker_model" "my_model" {
#   name               = var.model_name
#   execution_role_arn = var.sagemaker_execution_role_arn

#   primary_container {
#     image          = var.sagemaker_image_repository_name
#     model_data_url = "s3://${var.model_name}-model/${var.model_name}-model.tar.gz"
#   }
#   tags = var.tags
# }

# #TODO fix
# # data "aws_sagemaker_prebuilt_ecr_image" "image" {
# #   repository_name = var.sagemaker_image_repository_name
# # }


# resource "aws_sagemaker_endpoint_configuration" "endpoint_configuration" {
#   name = "${var.model_name}-endpoint-config"

#   production_variants {
#     model_name             = var.model_name
#     initial_instance_count = 1
#     instance_type          = var.endpoint_instance_type
#   }

#   tags = var.tags

# }

# resource "aws_sagemaker_endpoint" "model_endpoint" {
#   name                 = "${var.model_name}-endpoint"
#   endpoint_config_name = aws_sagemaker_endpoint_configuration.endpoint_configuration.name
#   tags                 = var.tags
# }

# resource "aws_sagemaker_domain" "example" {
#   domain_name = "${var.model_name}-domain"
#   auth_mode   = "IAM"
#   vpc_id      = var.vpc_id
#   subnet_ids  = var.subnet_ids

#   default_user_settings {
#     execution_role = var.sagemaker_execution_role_arn
#   }
# }




# # TODO Add API Gateway 








resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                  = "feature-engineering-notebook-instance"
  instance_type         = "ml.t3.medium"
  role_arn              = var.sagemaker_execution_role_arn
  lifecycle_config_name = aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_lifecycle_configuration.name
  tags                  = var.tags
}

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "sagemaker_lifecycle_configuration" {
  name = "mlops-sagemaker-lifecycle-config"
  on_start = base64encode(<<EOL
       #!/bin/bash
       # Location of the csv file 
       echo "key=${var.s3_obj_key}" > /home/ec2-user/SageMaker/.env
       echo "bucket=${var.s3_bucket}" >> /home/ec2-user/SageMaker/.env
       echo "target=${var.model_target}" >> /home/ec2-user/SageMaker/.env

       # Location of the scripts
       aws s3 sync s3://${var.mlops_s3_bucket}/ /home/ec2-user/SageMaker/ --delete --exact-timestamps
       chmod -R 777 /home/ec2-user/SageMaker/
     EOL
  )
}
