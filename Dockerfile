FROM quay.io/konflux-ci/buildah-task:latest
RUN dnf -y install git skopeo
