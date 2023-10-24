#Download an open source pycaret Docker image
FROM pycaret/full

# Install python-dotenv, s3fs, and sagemaker-training toolkit that contains the common functionality necessary to create a container compatible with SageMaker and the Python SDK.
RUN pip install python-dotenv 
RUN pip install s3fs 
RUN pip3 install sagemaker-training

# Copies the training code inside the container
COPY docker/*.py /opt/ml/code/

# Defines train.py as script entrypoint
ENV SAGEMAKER_PROGRAM train.py