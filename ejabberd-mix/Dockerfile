FROM alpine:3.7
MAINTAINER ProcessOne <contact@process-one.net>

RUN apk upgrade --update musl && \
    apk add build-base git zlib-dev openssl-dev yaml-dev expat-dev sqlite-dev \
            elixir erlang-crypto erlang-eunit erlang-mnesia erlang-xmerl erlang-erts \
            erlang-tools erlang-os-mon erlang-syntax-tools erlang-parsetools \
            erlang-runtime-tools erlang-reltool && \
    rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
    mix local.rebar --force

EXPOSE 5222 5280

ENTRYPOINT ["/usr/bin/mix"]

CMD ["compile"]
