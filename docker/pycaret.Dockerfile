#Download an open source TensorFlow Docker image
FROM tensorflow/tensorflow:latest-gpu-jupyter

# Install sagemaker-training toolkit that contains the common functionality necessary to create a container compatible with SageMaker and the Python SDK.
RUN pip3 install sagemaker-training

# Copies the training code inside the container
COPY docker/train.py /opt/ml/code/train.py

# Defines train.py as script entrypoint
ENV SAGEMAKER_PROGRAM train.py