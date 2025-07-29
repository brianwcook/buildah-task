FROM registry.access.redhat.com/ubi10/ubi-minimal:latest

# Install wget for downloading binaries
RUN microdnf install -y wget && \
    microdnf clean all

# Function to normalize architecture and install cosign
RUN echo 'alt_arch() { \
    local arch=$(uname -m); \
    if [ "$arch" = "aarch64" ]; then \
        echo "arm64"; \
    elif [ "$arch" = "x86_64" ]; then \
        echo "amd64"; \
    else \
        echo "$arch"; \
    fi; \
}' > /usr/local/bin/alt_arch && \
    chmod +x /usr/local/bin/alt_arch && \
    echo "Detected architecture: $(uname -m)" && \
    echo "Normalized architecture: $(alt_arch)" && \
    wget -O /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-$(alt_arch) && \
    chmod +x /usr/local/bin/cosign

# Install kubectl
RUN echo 'alt_arch() { \
    local arch=$(uname -m); \
    if [ "$arch" = "aarch64" ]; then \
        echo "arm64"; \
    elif [ "$arch" = "x86_64" ]; then \
        echo "amd64"; \
    else \
        echo "$arch"; \
    fi; \
}' > /usr/local/bin/alt_arch && \
    chmod +x /usr/local/bin/alt_arch && \
    wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v1.29.0/bin/linux/$(alt_arch)/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Install label-mod
RUN echo 'alt_arch() { \
    local arch=$(uname -m); \
    if [ "$arch" = "aarch64" ]; then \
        echo "arm64"; \
    elif [ "$arch" = "x86_64" ]; then \
        echo "amd64"; \
    else \
        echo "$arch"; \
    fi; \
}' > /usr/local/bin/alt_arch && \
    chmod +x /usr/local/bin/alt_arch && \
    wget -O /tmp/label-mod.tar.gz https://github.com/brianwcook/label-mod/releases/download/v1.1.0/label-mod-linux-$(alt_arch)-v1.1.0.tar.gz && \
    tar -xzf /tmp/label-mod.tar.gz -C /tmp && \
    mv /tmp/label-mod-linux-$(alt_arch) /usr/local/bin/label-mod && \
    chmod +x /usr/local/bin/label-mod && \
    rm /tmp/label-mod.tar.gz

# Clean up wget
RUN microdnf remove -y wget && \
    microdnf clean all

