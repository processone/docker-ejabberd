
[![Build Status](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml/badge.svg)](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml)

# docker-ejabberd

This repository contains a set of container images to run or develop ejabberd:

- [mix](mix/) (published in [docker.io/ejabberd/mix](https://hub.docker.com/r/ejabberd/mix/)
and [ghcr.io/processone/mix](https://github.com/processone/docker-ejabberd/pkgs/container/mix)):

  Build a development environment for ejabberd. See [mix README](mix/README.md) file for details.

- [ecs](ecs/) (published in [docker.io/ejabberd/ecs](https://hub.docker.com/r/ejabberd/ecs/)
and [ghcr.io/processone/ecs](https://github.com/processone/docker-ejabberd/pkgs/container/ecs)):

  Run ejabberd in a container with simple setup.
  See [ecs README](ecs/README.md) file for details.

- [code-server](code-server/) (published in [ghcr.io/processone/code-server](https://github.com/orgs/processone/packages/container/package/code-server)):

  Run Coder's code-server with a local ejabberd git clone.
  See [VSCode section](https://docs.ejabberd.im/developer/vscode/) in ejabberds Docs.

- [devcontainer](devcontainer/) (published in [ghcr.io/processone/devcontainer](https://github.com/orgs/processone/packages/container/package/devcontainer)):

  Use as a Dev Container for ejabberd in Visual Studio Code.
  See [VSCode section](https://docs.ejabberd.im/developer/vscode/) in ejabberds Docs.

The [ejabberd source code repository](https://github.com/processone/ejabberd) also provides:

- [ejabberd](https://github.com/processone/ejabberd/tree/master/.github/container) (published in [ghcr.io/processone/ejabberd](https://github.com/processone/ejabberd/pkgs/container/ejabberd)):

  Run ejabberd in a container with simple setup.
  See [ejabberd's CONTAINER](https://github.com/processone/ejabberd/blob/master/CONTAINER.md) file for details.
  Check the [differences between this image and `ecs`](https://github.com/processone/docker-ejabberd/blob/master/ecs/HUB-README.md#alternative-image-in-github).
