
[![Build Status](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml/badge.svg)](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml)

# docker-ejabberd

This repository contains a set of Docker images for ejabberd:

- [mix](mix/) (in Docker Hub: [ejabberd/mix](https://hub.docker.com/r/ejabberd/mix/)):
  allows you to build a development
  environment for ejabberd, using all dependencies packaged from the Docker image. You do not
  need anything else to build ejabberd from source and write your own ejabberd plugins.
- [ecs](ecs/) (in Docker Hub: [ejabberd/ecs](https://hub.docker.com/r/ejabberd/ecs/)):
  is suitable for running ejabberd with Docker in a simple, single-node setup.

Please read the README file in each repository for documentation for each image.
