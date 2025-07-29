FROM quay.io/konflux-ci/buildah-task:latest
RUN dnf -y install git skopeo

# Install cosign binary
RUN dnf -y install wget && \
    wget -O /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64 && \
    chmod +x /usr/local/bin/cosign && \
    wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    wget -O /usr/local/bin/regctl https://github.com/regclient/regclient/releases/latest/download/regctl-linux-amd64 && \
    chmod +x /usr/local/bin/regctl && \
    wget -O /tmp/label-mod.tar.gz https://github.com/brianwcook/label-mod/releases/download/v1.0.0/label-mod-linux-amd64-1.0.0.tar.gz && \
    tar -xzf /tmp/label-mod.tar.gz -C /tmp && \
    mv /tmp/label-mod-linux-amd64 /usr/local/bin/label-mod && \
    chmod +x /usr/local/bin/label-mod && \
    rm /tmp/label-mod.tar.gz && \
    dnf -y remove wget

