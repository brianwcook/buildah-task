FROM quay.io/konflux-ci/buildah-task:latest
RUN dnf -y install git skopeo

COPY label-mod-linux-amd64 /usr/local/bin/label-mod

# Install cosign binary
RUN dnf -y install wget && \
    wget -O /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 && \
    chmod +x /usr/local/bin/cosign && \
    wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    wget -O /usr/local/bin/regctl https://github.com/regclient/regclient/releases/latest/download/regctl-linux-amd64 && \
    chmod +x /usr/local/bin/regctl && \
    dnf -y remove wget && \
    chmod +x /usr/local/bin/label-mod

