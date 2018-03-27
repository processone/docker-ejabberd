#!/bin/sh

current=$(date +%y.%m)
version=${1:-$current}

docker build --build-arg VERSION=$version -t ejabberd/ecs:$version .
docker tag ejabberd/ecs:$version ejabberd/ecs:latest
