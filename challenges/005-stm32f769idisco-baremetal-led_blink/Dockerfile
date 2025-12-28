# Base Ubuntu
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install build essentials, CMake, Git, Python, QEMU
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        build-essential cmake git python3 python3-pip \
        wget gdb-multiarch xz-utils qemu-system-arm \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Unity test framework (optional)
RUN git clone https://github.com/ThrowTheSwitch/Unity.git /opt/unity \
    && ln -s /opt/unity/src /usr/local/include/unity

# ARM GCC toolchain
RUN wget -q https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && tar -xf arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi.tar.xz \
    && mv arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi /opt/arm \
    && rm *.tar.xz

# Qemu
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y qemu-system-arm qemu-efi \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


ENV PATH="/opt/arm/bin:${PATH}"

WORKDIR /workspaces/my-firmware-canvas/challenges/005-stm32f769idisco-ledblink
