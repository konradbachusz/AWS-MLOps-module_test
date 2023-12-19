locals {
  model_name       = var.model_name != "" ? var.model_name : "${var.resource_naming_prefix}-model"
  endpoint_name    = var.endpoint_name != "" ? var.endpoint_name : "${var.resource_naming_prefix}-endpoint"
  pycaret_ecr_name = var.pycaret_ecr_name != "" ? var.pycaret_ecr_name : "${var.resource_naming_prefix}-pycaret-repository"
}
