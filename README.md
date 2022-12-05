
[![Build Status](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml/badge.svg)](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml)

# docker-ejabberd

This repository contains a set of Docker images for ejabberd:

- [mix](mix/) (in Docker Hub: [ejabberd/mix](https://hub.docker.com/r/ejabberd/mix/)):

  Build a development environment for ejabberd. See [mix README](mix/README.md) file for details.

- [ecs](ecs/) (in Docker Hub: [ejabberd/ecs](https://hub.docker.com/r/ejabberd/ecs/)):

  Run ejabberd with Docker in a simple, single-node setup.
  See [ecs README](ecs/README.md) file for details.

- [code-server](code-server/) (in GitHub Container Registry: [processone/code-server](https://github.com/orgs/processone/packages/container/package/code-server)):

  Run Coder's code-server with a local ejabberd git clone.
  See [VSCode section](https://docs.ejabberd.im/developer/vscode/) in ejabberds Docs.

- [devcontainer](devcontainer/) (in GitHub Container Registry: [processone/devcontainer](https://github.com/orgs/processone/packages/container/package/devcontainer)):

  Use as a Dev Container for ejabberd in Visual Studio Code.
  See [VSCode section](https://docs.ejabberd.im/developer/vscode/) in ejabberds Docs.
