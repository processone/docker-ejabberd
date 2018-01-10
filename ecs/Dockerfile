FROM alpine:3.7
ARG VERSION
ENV TERM=xterm \
    LC_ALL=C.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    REPLACE_OS_VARS=true \
    HOME=/home/ejabberd \
    VERSION=${VERSION:-latest}
LABEL maintainer="ProcessOne <contact@process-one.net>" \
      product="Ejabberd Community Server" \
      version=$VERSION

# Create directory structure and user for ejabberd
RUN addgroup ejabberd -g 9000 \
 && adduser -s /bin/sh -D -G ejabberd ejabberd -u 9000 \
 && mkdir -p /home/ejabberd/config /home/ejabberd/db /home/ejabberd/log \
 && chown -R ejabberd:ejabberd /home/ejabberd

# Install required dependencies
RUN apk upgrade --update musl \
 && apk add \
    bash \
    ca-certificates \
    curl \
    expat \
    libstdc++ \
    ncurses-libs \
    openssl \
    sqlite \
    uthash \
    yaml \
    zlib \
 && rm -rf /var/cache/apk/* \
 && update-ca-certificates

# Install ejabberd
ADD ejabberd-$VERSION.tar.gz $HOME
COPY ejabberd-api ejabberdctl $HOME/bin/
COPY --chown=ejabberd:ejabberd config/* $HOME/config/
COPY docker-entrypoint.sh /

# Setup runtime environment
USER ejabberd
WORKDIR $HOME
VOLUME ["$HOME/db","$HOME/config","$HOME/log"]
EXPOSE 5222 5269 5280

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ejabberd"]
