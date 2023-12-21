##########################################
# Naming and Tagging
##########################################

variable "pycaret_ecr_name" {
  description = "Name of ECR repository that will be created and used to store the pycaret container image required for the model"
  type        = string
}
variable "tags" {
  description = "Tags applied to your resources"
}
