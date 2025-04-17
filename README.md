# Build Tools Container

A specialized CI/CD build tools container based on the official Podman v5.4.2 image, designed for GitLab pipelines and other container-based workflows.

## Features

This container provides essential tools for modern CI/CD pipelines:

- **Podman v5.4.2**: Container management with container-in-container support
- **Kubernetes Tools**: kubectl and Helm
- **Development Tools**: Python 3, Git, and common utilities
- **Data Processing**: jq and yq for JSON/YAML manipulation

## Building the Image

```bash
# Using the included script
./run/build_and_push.sh

# Or manually
docker build -t build-tools .
```

