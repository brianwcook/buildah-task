FROM quay.io/konflux-ci/buildah-task:latest
RUN dnf -y install git skopeo

# Install cosign binary
RUN dnf -y install wget && \
    wget -O /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 && \
    chmod +x /usr/local/bin/cosign && \
    dnf -y remove wget
