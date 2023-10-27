FROM ubuntu:latest

LABEL maintainer Amazon AI <sage-learner@amazon.com>


# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and install packages
RUN apt-get -q update && \
    apt-get -q install -y --no-install-recommends --fix-missing \
    wget \
    python3 \
    python3-pip \
    python3-setuptools \
    nginx \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# RUN ln -s /usr/bin/python3 /usr/bin/python
# RUN ln -s /usr/bin/pip3 /usr/bin/pip

# Here we get all python packages.
# There's substantial overlap between scipy and numpy that we eliminate by
# linking them together. Likewise, pip leaves the install caches populated which uses
# a significant amount of space. These optimizations save a fair amount of space in the
# image, which reduces start up time.

RUN apt-get update && apt-get install -y build-essential

RUN pip install --upgrade pip setuptools wheel

RUN pip install psutil



COPY ./requirements.txt /opt/program/requirements.txt
RUN ls /opt/program/
RUN pip install -r /opt/program/requirements.txt



# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
COPY pycaret /opt/program
WORKDIR /opt/program