FROM ghcr.io/actions/actions-runner:2.324.0

USER root

RUN apt update && apt install -y \
  curl git-lfs\
  libnss3\
  libnspr4\
  libatk1.0-0\
  libatk-bridge2.0-0\
  libcups2\
  libxcomposite1\
  libxdamage1\
  libxfixes3\
  libxrandr2\
  libgbm1\
  libxkbcommon0\
  libpango-1.0-0\
  libcairo2\
  libasound2\
  libatspi2.0-0\
  libx11-xcb1\
  libxcursor1\
  libgtk-3-0\
  libpangocairo-1.0-0\
  libcairo-gobject2\
  libgdk-pixbuf-2.0-0\
  ca-certificates

RUN mkdir -p /tmp/azcopy && \
  curl -L -o /tmp/azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux && \
  tar -Oxzf /tmp/azcopy.tar.gz > /tmp/azcopy/out && cp /tmp/azcopy/out /usr/local/bin/azcopy && \
  chmod +x /usr/local/bin/azcopy

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR /home/runner
USER runner
