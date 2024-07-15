
# Use the official image as a parent image
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Set the working directory in the container
WORKDIR /app

# Install Python and pip
RUN --mount=type=cache,target=/var/cache/apt     apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    build-essential \
    wget \
    unzip \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/* 

# Upgrade setuptools
RUN --mount=type=cache,target=/root/.cache/pip pip3 install --upgrade setuptools

# Install setuptools and wheel
RUN --mount=type=cache,target=/root/.cache/pip pip3 install setuptools wheel

RUN git clone https://github.com/davidguttman/audio-webui.git
RUN --mount=type=cache,target=/root/.cache/pip bash /app/install_linux_macos.sh
WORKDIR /app/audio-webui
COPY ./.env /app

# RUN --mount=type=cache,target=/root/.cache/pip bash /app/install.sh 
# RUN --mount=type=cache,target=/root/.cache/pip pip3 install tensorboardX
