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



# Use an official Python 3.8 runtime as a base image
FROM python:3.8

# Set environment variables
# ensures that Python outputs everything that's printed directly to the terminal (so logs can be seen in real-time)
ENV PYTHONUNBUFFERED=TRUE
# ensures Python doesn't try to write .pyc files to disk (useful for improving performance in some scenarios)
ENV PYTHONDONTWRITEBYTECODE=TRUE
# Update PATH environment variable to include /opt/program directory
ENV PATH="/opt/program:${PATH}"

# Set the working directory in the Docker image to /opt/program
WORKDIR /opt/program

RUN pip install --upgrade pip && \
    pip install pycaret[full] && \
    pip install python-dotenv && \
    pip install s3fs && \
    pip install sagemaker-training && \
    pip install sagemaker && \
    pip install gunicorn && \
    pip install Flask


# Copy the source code of the application
COPY docker/* /opt/program

ENTRYPOINT ["gunicorn", "-b", ":8080", "prediction_script:app"]

# ENTRYPOINT [ "python" ]

# CMD ["prediction_script.py"]