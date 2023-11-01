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
     EOL
  )
}
