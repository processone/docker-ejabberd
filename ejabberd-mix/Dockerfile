FROM alpine:3.5
MAINTAINER ProcessOne <contact@process-one.net>

RUN echo \
  && echo "http://nl.alpinelinux.org/alpine/v3.5/main" > /etc/apk/repositories \
  && echo "http://nl.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \

  # Install elixir from apk
  apk upgrade --update musl && \
  apk add build-base git zlib-dev openssl-dev yaml-dev expat-dev sqlite-dev \
   elixir erlang-crypto erlang-syntax-tools erlang-parsetools \
   erlang-eunit erlang-mnesia erlang-inets && \
  rm -rf /var/cache/apk/*


# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

EXPOSE 5222 5280

ENTRYPOINT ["/usr/bin/mix"]

CMD ["compile"]
