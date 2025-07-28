FROM quay.io/konflux-ci/buildah-task:latest
RUN dnf -y install git skopeo

# Install cosign binary
RUN dnf -y install wget && \
    wget -O /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 && \
    chmod +x /usr/local/bin/cosign && \
    wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    dnf -y remove wget

# Copy the public key for attestation verification
COPY rh03.pub /etc/cosign/keys/rh03.pub
