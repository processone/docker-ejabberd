FROM alpine:3.6
MAINTAINER ProcessOne <contact@process-one.net>

ENV REFRESHED_AT=2017-07-16 \
    HOME=/home/p1 \
    TERM=xterm \
    LC_ALL=C.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    REPLACE_OS_VARS=true

# Create directory structure and user for ejabberd
RUN addgroup p1 -g 9000 && adduser -s /bin/bash -D -G p1 p1 -u 9000 && \
	#RUN groupadd -r p1 --gid=999 && useradd -r -g p1 --uid=999 p1 && \
    mkdir -p ${HOME}/ejabberd \
    && mkdir ${HOME}/cfg \
    && mkdir ${HOME}/log \
    && mkdir ${HOME}/db && \
    chown -R p1:p1 ${HOME}

ENV P1DATA=${HOME}/db \
    P1LOG=${HOME}/log

COPY ejabberd.yml ${HOME}/cfg/

# TODO Make it possible to define which version of Alpine we would like to use.
RUN echo \
  && echo "http://nl.alpinelinux.org/alpine/v3.6/main" > /etc/apk/repositories \
  && echo "http://nl.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories && \

  apk upgrade --update musl && \
  apk add bash su-exec libstdc++ ncurses-libs openssl expat yaml zlib sqlite && \
  rm -rf /var/cache/apk/*

EXPOSE 5222 5269 5280

WORKDIR ${HOME}

COPY ejabberd.tar.gz ./
RUN tar -xzf ejabberd.tar.gz -C ${HOME}/ejabberd/ && \
  chmod -R 777 ${HOME}/ejabberd && \
  rm ${HOME}/ejabberd.tar.gz

# Volumes that you may want make persistent (share and backup)
VOLUME ["/home/p1/log/", "/home/p1/db/"]

WORKDIR /home/p1/ejabberd

COPY docker-entrypoint.sh /
COPY ejabberd-api /home/p1/

# CMD ./bin/ejabberd foreground
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ejabberd"]

