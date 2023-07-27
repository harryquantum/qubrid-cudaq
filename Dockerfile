FROM nvcr.io/nvidia/cuda-quantum:0.3.0

# Metadata
LABEL maintainer="harishankar.pv@qubrid.com"
LABEL version="1.0"
LABEL description="Docker image with CUDA Quantum, C++, Python3 and VSCode"

# Install dependencies
USER root
RUN apt-get update && \
    apt-get install -y curl 
    # apt-get install -y curl build-essential software-properties-common

# Install Python 3.9
# RUN add-apt-repository ppa:deadsnakes/ppa && \
#     apt-get update && \
#     apt-get install -y python3.9

# # Install necessary libraries for GPU acceleration
# RUN apt-get update && apt-get install -y nvidia-cuda-toolkit

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Disable password authentication for code-server
RUN mkdir -p /root/.config/code-server && \
    echo "bind-addr: 0.0.0.0:8080\nauth: none\ncert: false" > /root/.config/code-server/config.yaml

# Expose the code-server port
EXPOSE 8080

# Set the working directory
WORKDIR /workspace

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "."]
