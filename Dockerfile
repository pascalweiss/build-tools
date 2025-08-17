FROM quay.io/podman/stable:v5.4.2

# Installing essential tools for the container:
# - curl: For making HTTP requests and downloading files
# - python3 & py3-pip: For running Python scripts and installing Python packages
# - bash: Improved shell for scripting and interactive use
# - git: For version control and source code management
# - openssl: For SSL/TLS cryptographic functions
# - yq & jq: For parsing and manipulating YAML and JSON respectively
# - ca-certificates: For SSL certificate verification
# - unzip, tar, gzip: For working with compressed files and archives
# - nodejs & npm: For Node.js runtime and package management
RUN dnf install -y \
    curl \
    python3 \
    python3-pip \
    bash \
    git \
    openssl \
    jq \
    yq \
    ca-certificates \
    unzip \
    tar \
    gzip \
    nodejs \
    npm && \
    dnf clean all

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    VERIFY_CHECKSUM=false ./get_helm.sh && \
    rm get_helm.sh

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Note: We're using the "podman" user that's already configured in the base image
# This user is specifically set up for rootless podman operation
USER podman

# Verify installations (run as podman user to initialize npm cache with correct ownership)
RUN helm version && python3 --version && kubectl version --client && podman --version && node --version && npm --version

# Set working directory
WORKDIR /app

# Default to bash for better script compatibility in CI/CD
CMD ["/bin/bash"]