FROM alpine:3.18

LABEL maintainer="Your Name <your.email@example.com>"
LABEL description="CI/CD build tools container for GitLab pipelines"
LABEL version="1.0"

# Install dependencies - added CI/CD tools
RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip \
    bash \
    git \
    openssl \
    yq \
    jq \
    ca-certificates \
    unzip \
    tar \
    gzip

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    VERIFY_CHECKSUM=false ./get_helm.sh && \
    rm get_helm.sh

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Verify installations
RUN helm version && python3 --version && kubectl version --client

# Create non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set working directory
WORKDIR /app

# Default to bash for better script compatibility in CI/CD
CMD ["/bin/bash"]