#Download an open source pycaret Docker image
FROM pycaret/full

# Install gcc and other dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

RUN pip install python-dotenv 
RUN pip install s3fs 
RUN pip3 install sagemaker-training

# Copies the training code inside the container
COPY docker/*.py /opt/ml/code/

# Defines train.py as script entrypoint
ENV SAGEMAKER_PROGRAM train.py