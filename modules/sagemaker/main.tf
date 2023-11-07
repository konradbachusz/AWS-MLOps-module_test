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
       # Location of the scripts
       aws s3 sync s3://${var.config_bucket_id}/ /home/ec2-user/SageMaker/ --delete --exact-timestamps --exclude "*.env"

       # Make the ipython notebooks editable after copy
       chmod -R 777 /home/ec2-user/SageMaker/

       # Location of the csv file 
       echo "data_location_s3=${var.data_location_s3}" > /home/ec2-user/SageMaker/.env
       echo "target=${var.model_target_variable}" >> /home/ec2-user/SageMaker/.env
       echo "algorithm_choice=${var.algorithm_choice}" >> /home/ec2-user/SageMaker/.env
       echo "endpoint_name=${var.endpoint_name}" >> /home/ec2-user/SageMaker/.env
       echo "model_name=${var.model_name}" >> /home/ec2-user/SageMaker/.env
       echo "pycaret_ecr_name" = ${var.pycaret_ecr_name} >> /home/ec2-user/SageMaker/.env
       echo "instance_type" = ${var.sagemaker_instance_type} >> /home/ec2-user/SageMaker/.env
       echo "s3_model_name" = ${var.s3_model_name} >> /home/ec2-user/SageMaker/.env
     EOL
  )
}
# TODO: Add model_name + ecr_repo_name + endpoint name into lifecycle config