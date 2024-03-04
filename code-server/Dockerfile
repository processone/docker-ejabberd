FROM debian:testing-slim

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

RUN echo "export PATH=/workspaces/ejabberd/_build/relive:$PATH" >>/home/vscode/.bashrc
RUN echo "COOKIE" >/home/vscode/.erlang.cookie
RUN chmod 400 /home/vscode/.erlang.cookie

WORKDIR /workspaces/ejabberd
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:5208", "--auth", "none", "/workspaces/ejabberd"]
