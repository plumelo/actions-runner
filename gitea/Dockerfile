FROM gitea/runner-images:ubuntu-latest

USER root

RUN npx -y playwright-core@1.59.1 install-deps chromium

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl git-lfs ca-certificates \
  && rm -rf /var/lib/apt/lists/*
