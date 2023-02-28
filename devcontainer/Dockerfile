# [Choice] Alpine version: 3.16, 3.15, 3.14, 3.13
ARG VARIANT=latest
FROM alpine:${VARIANT}

RUN apk upgrade --update musl \
    && apk add \
    autoconf \
    automake \
    bash \
    build-base \
    curl \
    elixir \
    erlang-debugger \
    erlang-observer \
    erlang-odbc \
    erlang-reltool \
    expat-dev \
    file \
    gd-dev \
    git \
    jpeg-dev \
    libpng-dev \
    libwebp-dev \
    linux-pam-dev \
    openssl \
    openssl-dev \
    sqlite-dev \
    yaml-dev \
    zlib-dev

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG COMMON_SCRIPT_SOURCE="https://raw.githubusercontent.com/devcontainers/images/v0.2.31/src/base-alpine/.devcontainer/library-scripts/common-alpine.sh"
RUN apk update \
  && curl -sSL ${COMMON_SCRIPT_SOURCE} -o /tmp/common-alpine.sh \
  && ash /tmp/common-alpine.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" \
  && rm -rf /tmp/common-alpine.sh

RUN mix local.hex --force \
    && mix local.rebar --force

RUN apk add \
    expat \
    freetds \
    gd \
    jpeg \
    libgd \
    libpng \
    libstdc++ \
    libwebp \
    linux-pam \
    ncurses-libs \
    openssl \
    sqlite \
    sqlite-libs \
    unixodbc \
    yaml \
    zlib \
    && ln -fs /usr/lib/libtdsodbc.so.0 /usr/lib/libtdsodbc.so \
    && rm -rf /var/cache/apk/*
