##########################################
# Sagemaker
##########################################

variable "model_name" {
  description = "Name of the Sagemaker model"
  type        = string
}

variable "sagemaker_image_repository_name" {
  description = "Name of the repository, which is generally the algorithm or library. Values include blazingtext, factorization-machines, forecasting-deepar, image-classification, ipinsights, kmeans, knn, lda, linear-learner, mxnet-inference-eia, mxnet-inference, mxnet-training, ntm, object-detection, object2vec, pca, pytorch-inference-eia, pytorch-inference, pytorch-training, randomcutforest, sagemaker-scikit-learn, sagemaker-sparkml-serving, sagemaker-xgboost, semantic-segmentation, seq2seq, tensorflow-inference-eia, tensorflow-inference, tensorflow-training, huggingface-tensorflow-training, huggingface-tensorflow-inference, huggingface-pytorch-training, and huggingface-pytorch-inference."
  type        = string
}


variable "lambda_handler" {
  #TODO finish
}

variable "lambda_timeout" {
  #TODO finish
  type = number
}