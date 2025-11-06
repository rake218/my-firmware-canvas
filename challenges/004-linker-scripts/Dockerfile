# challenges/004-linker-scripts/Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    gcc \
    ca-certificates \
    wget \
    binutils \
    qemu-system-arm \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install ARM cross toolchain from apt (adjust if you need a pinned version)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["/bin/bash"]
