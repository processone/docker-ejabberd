FROM alpine:3.4
MAINTAINER ProcessOne <contact@process-one.net>

# Install elixir from apk
RUN apk --update add build-base git zlib-dev openssl-dev yaml-dev expat-dev \
   elixir erlang-crypto erlang-syntax-tools erlang-parsetools \
   erlang-eunit erlang-mnesia && rm -rf /var/cache/apk/*

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

EXPOSE 5222 5280

ENTRYPOINT ["/usr/bin/mix"]

CMD ["compile"]
