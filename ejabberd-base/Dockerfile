FROM alpine:3.6
MAINTAINER ProcessOne <contact@process-one.net>

ENV REFRESHED_AT=2017-11-21 \
    HOME=/home/p1 \
    TERM=xterm \
    LC_ALL=C.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    REPLACE_OS_VARS=true

# Create directory structure and user for ejabberd
RUN addgroup p1 -g 9000 && adduser -s /bin/bash -D -G p1 p1 -u 9000 && \
    mkdir -p ${HOME}/ejabberd ${HOME}/ejabberd/config ${HOME}/ejabberd/log ${HOME}/ejabberd/mnesiadb && \
    chown -R p1:p1 ${HOME}

ENV P1DATA=${HOME}/ejabberd/mnesiadb \
    P1LOG=${HOME}/ejabberd/log \
    P1CFG=${HOME}/ejabberd/config

COPY ejabberd.yml ${HOME}/ejabberd/config/
COPY server.pem ${HOME}/ejabberd/config/

# TODO Make it possible to define which version of Alpine we would like to use.
#RUN echo "http://nl.alpinelinux.org/alpine/v3.6/main" > /etc/apk/repositories && \
#    echo "http://nl.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories && \
RUN apk upgrade --update musl && \
    apk add bash su-exec libstdc++ ncurses-libs openssl expat yaml zlib sqlite && \
    apk add curl ca-certificates && update-ca-certificates && \
    rm -rf /var/cache/apk/*

EXPOSE 5222 5269 5280

WORKDIR ${HOME}

COPY ejabberd.tar.gz ./
RUN tar -xzf ejabberd.tar.gz -C ${HOME}/ejabberd/ && \
  chmod -R 777 ${HOME}/ejabberd && \
  rm ${HOME}/ejabberd.tar.gz

# Volumes that you may want make persistent (share and backup)
VOLUME ["/home/p1/ejabberd/log/","/home/p1/ejabberd/mnesiadb/","/home/p1/ejabberd/config/"]

WORKDIR ${HOME}/ejabberd

COPY docker-entrypoint.sh /
COPY ejabberd-api ${HOME}

# CMD ./bin/ejabberd foreground
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ejabberd"]

