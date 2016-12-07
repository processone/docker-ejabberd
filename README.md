# docker-ejabberd

This repository contains a set of Docker images for ejabberd.

- [ejabberd/mix](https://hub.docker.com/r/ejabberd/mix/): This image allows you to build develop for ejabberd, using
  all dependencies packaged from the Docker image. You do not need anything else
  to build ejabberd from source and write your own ejabberd plugins.
- [ejabberd/ecs](https://hub.docker.com/r/ejabberd/ecs/): This image is build from ejabberd-base. It generates an image
  suitable for running ejabberd with Docker in a simple, single-node cluster setup.

Please read the README file in each repository for documentation for each image.
