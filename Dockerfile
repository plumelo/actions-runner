FROM ghcr.io/actions/actions-runner:2.322.0

USER root

RUN apt update && apt install -y curl git-lfs

WORKDIR /home/runner
USER runner
