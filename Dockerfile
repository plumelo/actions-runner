FROM ghcr.io/actions/actions-runner:2.334.0

USER root

RUN rm -f /etc/apt/sources.list.d/*git-core* \
    /etc/apt/sources.list.d/*ppa* \
    /etc/apt/sources.list.d/*launchpad* \
    /etc/apt/sources.list.d/*packagecloud*

RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://azure.archive.ubuntu.com/ubuntu|g' \
        /etc/apt/sources.list /etc/apt/sources.list.d/*.sources 2>/dev/null || true && \
    sed -i 's|http://security.ubuntu.com/ubuntu|http://azure.archive.ubuntu.com/ubuntu|g' \
        /etc/apt/sources.list /etc/apt/sources.list.d/*.sources 2>/dev/null || true

RUN apt update \
    && apt install -y curl \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null \
    && apt update \
    && apt install -y gh \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ noble main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt update \
    && apt install -y azure-cli \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
    | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" \
    | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN npx -y playwright-core@1.59.1 install-deps chromium

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git-lfs age ca-certificates zip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/azcopy \
    && curl -L -o /tmp/azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux \
    && tar -xf /tmp/azcopy.tar.gz -C /tmp/azcopy --strip-components=1 && cp /tmp/azcopy/azcopy /usr/local/bin/azcopy \
    && chmod +x /usr/local/bin/azcopy

RUN SOPS_VERSION=$(curl -s "https://api.github.com/repos/getsops/sops/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+') \
    && curl -Lo sops "https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64" \
    && chmod +x sops \
    && mv sops /usr/local/bin/

WORKDIR /home/runner
USER runner
