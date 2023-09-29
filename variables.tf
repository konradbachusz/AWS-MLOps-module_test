##########################################
# Common
##########################################

variable "tags" {
  description = "Tags applied to your resources"
  default     = {}
}

##########################################
# Sagemaker
##########################################

variable "model_name" {
  description = "Name of the Sagemaker model"
  type        = string
  default     = ""
}

variable "sagemaker_image_repository_name" {
  description = "Name of the repository, which is generally the algorithm or library. Values include blazingtext, factorization-machines, forecasting-deepar, image-classification, ipinsights, kmeans, knn, lda, linear-learner, mxnet-inference-eia, mxnet-inference, mxnet-training, ntm, object-detection, object2vec, pca, pytorch-inference-eia, pytorch-inference, pytorch-training, randomcutforest, sagemaker-scikit-learn, sagemaker-sparkml-serving, sagemaker-xgboost, semantic-segmentation, seq2seq, tensorflow-inference-eia, tensorflow-inference, tensorflow-training, huggingface-tensorflow-training, huggingface-tensorflow-inference, huggingface-pytorch-training, and huggingface-pytorch-inference."
  type        = string
  default     = ""
}

variable "endpoint_instance_type" {
  description = "Type of EC2 instance used for model endpoint"
  type        = string
  default     = ""
}

variable "model_api_endpoint" {
  description = "Name of the API endpoint used for the machine learning model"
  type        = string
}

#### Networking ####

variable "vpc_id" {
  description = "The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication."
  type        = string
}

variable "subnet_ids" {
  description = "The VPC subnets that Studio uses for communication."
  type        = list(any)
}

