# Base: Ubuntu with build tools
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install build essentials and git
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        python3 \
        python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Unity (simple: clone into /opt and symlink)
RUN git clone https://github.com/ThrowTheSwitch/Unity.git /opt/unity \
    && ln -s /opt/unity/src /usr/local/include/unity

# Set working directory
WORKDIR /workspaces/my-firmware-canvas
