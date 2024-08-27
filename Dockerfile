# Use a base image with a minimal Linux distribution
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache curl unzip

# Set Packer version
ENV PACKER_VERSION=1.11.2

# Download and install Packer
RUN curl -O https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
  unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin && \
  rm packer_${PACKER_VERSION}_linux_amd64.zip

# Verify Packer installation
RUN packer --version

# Set the working directory
WORKDIR /packer
