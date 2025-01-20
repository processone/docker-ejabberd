FROM debian:sid-slim

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        curl ca-certificates \
        autoconf automake git make gcc g++ \
        erlang erlang-dev elixir rebar3 \
        libexpat1-dev libgd-dev libpam0g-dev \
        libsqlite3-dev libwebp-dev libyaml-dev \
        libssl-dev

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN addgroup vscode --gid 1000 \
    && adduser --shell /bin/bash --ingroup vscode vscode -u 1000

USER vscode

RUN /usr/bin/code-server --install-extension erlang-ls.erlang-ls

WORKDIR /home/vscode
RUN echo "export PATH=/workspaces/ejabberd/_build/relive:$PATH" >>.bashrc \
    && echo "COOKIE" >.erlang.cookie \
    && chmod 400 .erlang.cookie

WORKDIR /workspaces/ejabberd
VOLUME ["workspaces/ejabberd"]
EXPOSE 1870 1883 4369-4399 5210 5222 5269 5280 5443

ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:1870", "--auth", "none", "/workspaces/ejabberd"]
