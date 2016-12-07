FROM alpine:3.4
MAINTAINER ProcessOne <contact@process-one.net>

RUN echo \
  # Replacing default repositories with edge ones as we need Elixir 1.3.x
  # Previous version of Elixir do not handle our deps properly
  && echo @stable "http://dl-cdn.alpinelinux.org/alpine/v3.4/main" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \

  # Install elixir from apk
  apk add --no-cache build-base git zlib-dev openssl-dev yaml-dev expat-dev@stable \
   elixir erlang-crypto erlang-syntax-tools erlang-parsetools \
   erlang-eunit erlang-mnesia

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

EXPOSE 5222 5280

ENTRYPOINT ["/usr/bin/mix"]

CMD ["compile"]
