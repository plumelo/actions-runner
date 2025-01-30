FROM ghcr.io/actions/actions-runner:2.322.0

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
  libgdk-pixbuf-2.0-0

WORKDIR /home/runner
USER runner
