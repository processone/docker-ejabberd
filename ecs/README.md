
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Docker Stars](https://img.shields.io/docker/stars/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Docker Pulls](https://img.shields.io/docker/pulls/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Build Status](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml/badge.svg)](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml)
[![GitHub stars](https://img.shields.io/github/stars/processone/docker-ejabberd?style=social)](https://github.com/processone/docker-ejabberd)

# ejabberd Community Server

ejabberd is an open-source XMPP server, robust, scalable and modular,
built using Erlang/OTP, and also includes MQTT Broker and SIP Service.

This Docker image allows you to run a single node ejabberd instance in a Docker container.

If you are using a Windows operating system, check the tutorials mentioned in
[ejabberd Docs > Docker Image](https://docs.ejabberd.im/admin/installation/#docker-image).

# Start ejabberd

## With default configuration

You can start ejabberd in a new container with the following command:

```bash
docker run --name ejabberd -d -p 5222:5222 ejabberd/ecs
```

This command will run Docker image as a daemon,
using ejabberd default configuration file and XMPP domain "localhost".

To stop the running container, you can run:

```bash
docker stop ejabberd
```

If needed, you can restart the stopped ejabberd container with:

```bash
docker restart ejabberd
```

## Start with Erlang console attached

If you would like to start ejabberd with an Erlang console attached you can use the `live` command:

```bash
docker run -it -p 5222:5222 ejabberd/ecs live
```

This command will use default configuration file and XMPP domain "localhost".

## Start with your configuration and database

The following command will pass config file using Docker volume feature
and share local directory to store database:

```bash
mkdir database
docker run -d --name ejabberd -v $(pwd)/ejabberd.yml:/home/ejabberd/conf/ejabberd.yml -v $(pwd)/database:/home/ejabberd/database -p 5222:5222 ejabberd/ecs
```

# Next steps

## Register the administrator account

The default ejabberd configuration has already granted admin privilege
to an account that would be called `admin@localhost`,
so you just need to register such an account
to start using it for administrative purposes.
You can register this account using the `ejabberdctl` script, for example:

```bash
docker exec -it ejabberd bin/ejabberdctl register admin localhost passw0rd
```

## Check ejabberd log files

You can execute a Docker command to check the content of the log files from
inside to container, even if you do not put it on a shared persistent drive:

```bash
docker exec -it ejabberd tail -f logs/ejabberd.log
```

## Inspect the container files

The container uses Alpine Linux. You can start a shell there with:

```bash
docker exec -it ejabberd sh
```

## Open ejabberd debug console

You can open a live debug Erlang console attached to a running container:

```bash
docker exec -it ejabberd bin/ejabberdctl debug
```

## CAPTCHA

ejabberd includes two example CAPTCHA scripts.
If you want to use any of them, first install some additional required libraries:

```bash
docker exec --user root ejabberd apk add imagemagick ghostscript-fonts bash
```

Now update your ejabberd configuration file, for example:
```bash
docker exec -it ejabberd vi conf/ejabberd.yml
```

and add the required options:
```
captcha_cmd: /home/ejabberd/lib/ejabberd-21.1.0/priv/bin/captcha.sh
captcha_url: https://localhost:5443/captcha
```

Finally, reload the configuration file or restart the container:
```bash
docker exec ejabberd bin/ejabberdctl reload_config
```

## Use ejabberdapi

When the container is running (and thus ejabberd), you can exec commands inside the container
using `ejabberdctl` or any other of the available interfaces, see
[Understanding ejabberd "commands"](https://docs.ejabberd.im/developer/ejabberd-api/#understanding-ejabberd-commands)

Additionally, this Docker image includes the `ejabberdapi` executable.
Please check the [ejabberd-api homepage](https://github.com/processone/ejabberd-api)
for configuration and usage details.

For example, if you configure ejabberd like this:
```yaml
listen:
  -
    port: 5282
    module: ejabberd_http
    request_handlers:
      "/api": mod_http_api

acl:
  loopback:
    ip:
      - 127.0.0.0/8
      - ::1/128
      - ::FFFF:127.0.0.1/128

api_permissions:
  "admin access":
    who:
      access:
        allow:
          acl: loopback
    what:
      - "register"
```

Then you could register new accounts with this query:

```bash
docker exec -it ejabberd bin/ejabberdapi register --endpoint=http://127.0.0.1:5282/ --jid=admin@localhost --password=passw0rd
```

# Advanced Docker configuration

## Ports

This Docker image exposes the ports:

- `5222`: The default port for XMPP clients.
- `5269`: For XMPP federation. Only needed if you want to communicate with users on other servers.
- `5280`: For admin interface.
- `5443`: With encryption, used for admin interface, API, CAPTCHA, OAuth, Websockets and XMPP BOSH.
- `1883`: Used for MQTT
- `4369-4399`: EPMD and Erlang connectivity, used for `ejabberdctl` and clustering

## Volumes

ejabberd produces two types of data: log files and database (Mnesia).
This is the kind of data you probably want to store on a persistent or local drive (at least the database).

Here are the volume you may want to map:

- `/home/ejabberd/conf/`: Directory containing configuration and certificates
- `/home/ejabberd/database/`: Directory containing Mnesia database.
You should back up or export the content of the directory to persistent storage
(host storage, local storage, any storage plugin)
- `/home/ejabberd/logs/`: Directory containing log files
- `/home/ejabberd/upload/`: Directory containing uploaded files. This should also be backed up.

All these files are owned by ejabberd user inside the container. Corresponding
`UID:GID` is `9000:9000`. If you prefer bind mounts instead of docker volumes, then
you need to map this to valid `UID:GID` on your host to get read/write access on
mounted directories.

# Generating ejabberd release

## Configuration

Image is built by embedding an ejabberd Erlang/OTP standalone release in the image.

The configuration of ejabberd Erlang/OTP release is customized with:

- `rel/config.exs`: Customize ejabberd release
- `rel/dev.exs`: ejabberd environment configuration for development release
- `rel/prod.exs`: ejabberd environment configuration for production Docker release
- `vars.config`: ejabberd compilation configuration options
- `conf/ejabberd.yml`: ejabberd default config file

Build ejabberd Community Server base image from ejabberd master on Github:

```bash
docker build -t ejabberd/ecs .
```

Build ejabberd Community Server base image for a given ejabberd version:

```bash
./build.sh 18.03
```
