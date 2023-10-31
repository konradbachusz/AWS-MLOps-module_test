

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
       set -e  # Exit if any command fails
       
       # Sync scripts from S3
       aws s3 sync s3://${var.s3_bucket_id}/ /home/ec2-user/SageMaker/ --delete --exact-timestamps --exclude "*.env"

       # Update permissions
       chmod -R 777 /home/ec2-user/SageMaker/

       # Populate environment variables
       echo "data_location_s3=${var.data_location_s3}" > /home/ec2-user/SageMaker/.env
       echo "target=${var.model_target}" >> /home/ec2-user/SageMaker/.env
       echo "algorithm_choice=${var.algorithm_choice}" >> /home/ec2-user/SageMaker/.env

       sudo -u ec2-user -i <<'INNER_EOF'
      ENVIRONMENT=python3
      source /home/ec2-user/anaconda3/bin/activate "$$ENVIRONMENT"
      # pip install --ignore-installed pycaret
      pip install python-dotenv
      pip install s3fs
      source /home/ec2-user/anaconda3/bin/deactivate
      INNER_EOF
  EOL
  )
}


# resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "sagemaker_lifecycle_configuration" {
#   name = "mlops-sagemaker-lifecycle-config"
#   on_start = base64encode(<<EOL
#        #!/bin/bash
#        # Location of the scripts
#        aws s3 sync s3://${var.s3_bucket_id}/ /home/ec2-user/SageMaker/ --delete --exact-timestamps --exclude "*.env"

#        # Make the ipython notebooks editable after copy
#        chmod -R 777 /home/ec2-user/SageMaker/

#        # Location of the csv file 
#        echo "data_location_s3=${var.data_location_s3}" > /home/ec2-user/SageMaker/.env
#        echo "target=${var.model_target}" >> /home/ec2-user/SageMaker/.env
#        echo "algorithm_choice=${var.algorithm_choice}" >> /home/ec2-user/SageMaker/.env

#      EOL
#   )
# }
