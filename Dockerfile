FROM registry.access.redhat.com/ubi10/ubi-minimal:latest

# Install wget, tar, and gzip for downloading and extracting binaries
RUN microdnf install -y wget tar gzip git buildah skopeo && \
    microdnf clean all

# Install cosign with architecture detection
RUN set -e && \
    ARCH=$(uname -m) && \
    echo "Detected architecture: $ARCH" && \
    if [ "$ARCH" = "aarch64" ]; then \
        ALT_ARCH="arm64"; \
    elif [ "$ARCH" = "x86_64" ]; then \
        ALT_ARCH="amd64"; \
    else \
        ALT_ARCH="$ARCH"; \
    fi && \
    echo "Normalized architecture: $ALT_ARCH" && \
    wget --quiet -O /usr/local/bin/cosign "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-$ALT_ARCH" && \
    chmod +x /usr/local/bin/cosign

# Install kubectl with architecture detection
RUN set -e && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then \
        ALT_ARCH="arm64"; \
    elif [ "$ARCH" = "x86_64" ]; then \
        ALT_ARCH="amd64"; \
    else \
        ALT_ARCH="$ARCH"; \
    fi && \
    wget --quiet -O /usr/local/bin/kubectl "https://dl.k8s.io/release/v1.29.0/bin/linux/$ALT_ARCH/kubectl" && \
    chmod +x /usr/local/bin/kubectl

# Install label-mod with architecture detection
RUN set -e && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then \
        ALT_ARCH="arm64"; \
    elif [ "$ARCH" = "x86_64" ]; then \
        ALT_ARCH="amd64"; \
    else \
        ALT_ARCH="$ARCH"; \
    fi && \
    wget --quiet -O /tmp/label-mod.tar.gz "https://github.com/brianwcook/label-mod/releases/download/v1.1.0/label-mod-linux-$ALT_ARCH-v1.1.0.tar.gz" && \
    tar -xzf /tmp/label-mod.tar.gz -C /tmp && \
    mv "/tmp/label-mod-linux-$ALT_ARCH" /usr/local/bin/label-mod && \
    chmod +x /usr/local/bin/label-mod && \
    rm /tmp/label-mod.tar.gz

# Clean up wget, tar, and gzip
RUN microdnf remove -y wget tar gzip && \
    microdnf clean all

