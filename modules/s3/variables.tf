variable "tags" {
  description = "Tags applied to your resources"
}

variable "model_name" {
  description = "Name of the Sagemaker model"
  type        = string
}

variable "preprocessing_script_path" {
  description = "The path the user provides if they want to include their own data cleaning logic"
  type        = string
  default     = "None"
}
