FROM pycaret/full

USER root
# Install gcc and other dependencies
RUN apt-get update && \
    apt-get install -y build-essential gcc && \
    rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install python-dotenv && \
    pip install s3fs && \
    pip3 install sagemaker-training

# Copies the training code inside the container
COPY *.py /opt/ml/code/

# Defines train.py as script entrypoint
ENV SAGEMAKER_PROGRAM train.py