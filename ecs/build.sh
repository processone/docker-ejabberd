#!/bin/bash

VERSION=${1:-HEAD}
REF=$VERSION
[ "$VERSION" = "HEAD" ] && VERSION=latest
ARCHIVE=ejabberd-${VERSION}.tar.gz

GREEN='\033[0;32m'
NC='\033[0m' # No Color]]'

docker images | grep -q "ejabberd/mix" || {
	echo -e "${GREEN}Pulling ejabberd build Docker image${NC}"
	docker pull ejabberd/mix
}

if [ ! -d ejbuild ]; then
	echo -e "${GREEN}Cloning ejabberd${NC}"
	git clone https://github.com/processone/ejabberd.git ejbuild
else
	echo -e "${GREEN}Fetch ejabberd${NC}"
	(cd ejbuild; git checkout master && git pull)
fi
cat > ejbuild/vars.config <<EOF
{mysql, true}.
{pgsql, true}.
{sqlite, true}.
{zlib, true}.
{redis, true}.
{elixir, true}.
{iconv, true}.
EOF

if [ ! -e ${ARCHIVE} ]; then
	echo -e "${GREEN}Checkout ejabberd ${REF}${NC}"
	(cd ejbuild; git checkout $REF)
	echo -e "${GREEN}Building ejabberd release${NC}"
	# Copy release configuration
	cp rel/*.exs ejbuild/rel/
	# Force clock resync ?
	#docker run -it  --rm --privileged --entrypoint="/sbin/hwclock" ejabberd/mix -s
	# Build ejabberd and generate release
	docker run -it -v $(pwd)/ejbuild:$(pwd)/ejbuild -w $(pwd)/ejbuild -e "MIX_ENV=prod" ejabberd/mix do clean, deps.get, deps.compile, compile, release.init, release --env=prod
	# Copy generated ejabberd release archive 
	relvsn=$(grep version ejbuild/mix.exs | cut -d'"' -f2)
	cp ejbuild/_build/prod/rel/ejabberd/releases/$relvsn/ejabberd.tar.gz ${ARCHIVE}
fi

# Build ejabberd base container
echo -e "${GREEN}Building ejabberd Community Edition container${NC}"
docker build --build-arg VERSION=${VERSION} -t ejabberd/ecs:${VERSION} .
