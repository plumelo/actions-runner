FROM ghcr.io/actions/actions-runner:2.331.0

USER root

RUN apt update \
    && apt install -y curl \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install -y \
      git-lfs \
      gh \
      libnss3 \
      libnspr4 \
      libatk1.0-0 \
      libatk-bridge2.0-0 \
      libcups2 \
      libxcomposite1 \
      libxdamage1 \
      libxfixes3 \
      libxrandr2 \
      libgbm1 \
      libxkbcommon0 \
      libpango-1.0-0 \
      libcairo2 \
      libasound2 \
      libatspi2.0-0 \
      libx11-xcb1 \
      libxcursor1 \
      libgtk-3-0 \
      libpangocairo-1.0-0 \
      libcairo-gobject2 \
      libgdk-pixbuf-2.0-0 \
      ca-certificates \
      zip

RUN mkdir -p /tmp/azcopy && \
  curl -L -o /tmp/azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux && \
  tar -xf /tmp/azcopy.tar.gz -C /tmp/azcopy --strip-components=1 && cp /tmp/azcopy/azcopy /usr/local/bin/azcopy && \
  chmod +x /usr/local/bin/azcopy

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

WORKDIR /home/runner
USER runner
