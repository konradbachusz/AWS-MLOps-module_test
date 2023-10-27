# FROM pycaret/full

# USER root
# # Install gcc and other dependencies
# RUN apt-get update && \
#     apt-get install -y build-essential gcc && \
#     rm -rf /var/lib/apt/lists/*

# # Install Python packages
# RUN pip install --upgrade pip\
#     pip install python-dotenv && \
#     pip install s3fs && \
#     pip3 install sagemaker-training \
#     pip install sagemaker \ 
#     pip install gunicorn

# # Copies the training code inside the container
# COPY docker/*.py /opt/ml/code/

# # Defines train.py as script entrypoint
# ENV SAGEMAKER_PROGRAM train.py

# ENTRYPOINT ["gunicorn", "-b", ":8080", "prediction_script:app"]



# # Use an official Python 3.8 runtime as a base image
# FROM python:3.8

# # Set environment variables
# # ensures that Python outputs everything that's printed directly to the terminal (so logs can be seen in real-time)
# ENV PYTHONUNBUFFERED=TRUE
# # ensures Python doesn't try to write .pyc files to disk (useful for improving performance in some scenarios)
# ENV PYTHONDONTWRITEBYTECODE=TRUE
# # Update PATH environment variable to include /opt/program directory
# ENV PATH="/opt/program:${PATH}"

# # Set the working directory in the Docker image to /opt/program
# WORKDIR /opt/program

# RUN pip install --upgrade pip && \
#     pip install pycaret[full] && \
#     pip install python-dotenv && \
#     pip install s3fs && \
#     pip install sagemaker-training && \
#     pip install sagemaker && \
#     pip install gunicorn && \
#     pip install Flask


# # Copy the source code of the application
# COPY docker/* /opt/program

# ENTRYPOINT ["gunicorn", "-b", ":8080", "prediction_script:app"]

# # ENTRYPOINT [ "python" ]

# # CMD ["prediction_script.py"]




FROM ubuntu:18.04

LABEL maintainer Amazon AI <sage-learner@amazon.com>


RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python3-pip \
         python3-setuptools \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

# Here we get all python packages.
# There's substantial overlap between scipy and numpy that we eliminate by
# linking them together. Likewise, pip leaves the install caches populated which uses
# a significant amount of space. These optimizations save a fair amount of space in the
# image, which reduces start up time.
RUN pip --no-cache-dir install numpy==1.16.2 scipy==1.2.1 scikit-learn==0.20.2 pandas flask gunicorn

# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
COPY decision_trees /opt/program
WORKDIR /opt/program