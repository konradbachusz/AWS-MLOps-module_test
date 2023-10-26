FROM pycaret/full

USER root
# Install gcc and other dependencies
RUN apt-get update && \
    apt-get install -y build-essential gcc && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install python-dotenv && \
    pip install s3fs && \
    pip3 install sagemaker-training \
    pip install sagemaker

# Copies the training code inside the container
COPY docker/*.py /opt/ml/code/

# Defines train.py as script entrypoint
ENV SAGEMAKER_PROGRAM train.py





# #Download an open source TensorFlow Docker image
# FROM tensorflow/tensorflow:latest-gpu-jupyter

# # Install sagemaker-training toolkit that contains the common functionality necessary to create a container compatible with SageMaker and the Python SDK.
# RUN pip3 install sagemaker-training

# # Copies the training code inside the container
# COPY docker/*.py /opt/ml/code/

# # Defines train.py as script entrypoint
# ENV SAGEMAKER_PROGRAM tester.py