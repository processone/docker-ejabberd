#!/bin/sh

current=$(date +%y.%m)
version=${1:-$current}

docker build --build-arg VERSION=$version -t ejabberd/ecs:$version .
[ "$version" = "latest" ] || docker tag ejabberd/ecs:$version ejabberd/ecs:latest
