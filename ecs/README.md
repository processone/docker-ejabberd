
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Docker Stars](https://img.shields.io/docker/stars/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Docker Pulls](https://img.shields.io/docker/pulls/ejabberd/ecs)](https://hub.docker.com/r/ejabberd/ecs/)
[![Build Status](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml/badge.svg)](https://github.com/processone/docker-ejabberd/actions/workflows/tests.yml)
[![GitHub stars](https://img.shields.io/github/stars/processone/docker-ejabberd?style=social)](https://github.com/processone/docker-ejabberd)

# ejabberd Community Server

ejabberd is an open-source XMPP server, robust, scalable and modular,
built using Erlang/OTP, and also includes MQTT Broker and SIP Service.

This container image allows you to run a single node ejabberd instance in a container.

There is an [Alternative Image in GitHub Packages](HUB-README.md#alternative-image-in-github), built using a different method and some improvements.

If you are using a Windows operating system, check the tutorials mentioned in
[ejabberd Docs > Docker Image](https://docs.ejabberd.im/admin/installation/#docker-image).

# Start ejabberd

## With default configuration

You can start ejabberd in a new container with the following command:

```bash
docker run --name ejabberd -d -p 5222:5222 ejabberd/ecs
```

This command will run the container image as a daemon,
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

This command passes the configuration file using the volume feature
and shares the local directory to store database:

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

Check the ejabberd log file in the container:

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

and add this option:
```yaml
captcha_cmd: /home/ejabberd/lib/ejabberd-21.1.0/priv/bin/captcha.sh
```

Finally, reload the configuration file or restart the container:
```bash
docker exec ejabberd bin/ejabberdctl reload_config
```

If the CAPTCHA image is not visible, there may be a problem generating it
(the ejabberd log file may show some error message);
or the image URL may not be correctly detected by ejabberd,
in that case you can set the correct URL manually, for example:
```yaml
captcha_url: https://localhost:5443/captcha
```

For more details about CAPTCHA options, please check the
[CAPTCHA](https://docs.ejabberd.im/admin/configuration/basic/#captcha)
documentation section.


## Use ejabberdapi

When the container is running (and thus ejabberd), you can exec commands inside the container
using `ejabberdctl` or any other of the available interfaces, see
[Understanding ejabberd "commands"](https://docs.ejabberd.im/developer/ejabberd-api/#understanding-ejabberd-commands)

Additionally, this container image includes the `ejabberdapi` executable.
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

# Advanced container configuration

## Ports

This container image exposes the ports:

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
`UID:GID` is `9000:9000`. If you prefer bind mounts instead of volumes, then
you need to map this to valid `UID:GID` on your host to get read/write access on
mounted directories.

## Commands on start

The ejabberdctl script reads the `CTL_ON_CREATE` environment variable
the first time the container is started,
and reads `CTL_ON_START` every time the container is started.
Those variables can contain one ejabberdctl command,
or several commands separated with the blankspace and `;` characters.

By default failure of any of commands executed that way would
abort start, this can be disabled by prefixing commands with `!`

Example usage (or check the [full example](#customized-example)):
```yaml
    environment:
      - CTL_ON_CREATE=! register admin localhost asd
      - CTL_ON_START=stats registeredusers ;
                     check_password admin localhost asd ;
                     status
```

## Clustering

When setting several containers to form a
[cluster of ejabberd nodes](https://docs.ejabberd.im/admin/guide/clustering/),
each one must have a different
[Erlang Node Name](https://docs.ejabberd.im/admin/guide/security/#erlang-node-name)
and the same
[Erlang Cookie](https://docs.ejabberd.im/admin/guide/security/#erlang-cookie).
For this you can either:
- edit `conf/ejabberdctl.cfg` and set variables `ERLANG_NODE` and `ERLANG_COOKIE`
- set the environment variables `ERLANG_NODE_ARG` and `ERLANG_COOKIE`

Once you have the ejabberd nodes properly set and running,
you can tell the secondary nodes to join the master node using the
[`join_cluster`](https://docs.ejabberd.im/developer/ejabberd-api/admin-api/#join-cluster)
API call.

Example using environment variables (see the full
[`docker-compose.yml` clustering example](#clustering-example)):
```yaml
environment:
  - ERLANG_NODE_ARG=ejabberd@replica
  - ERLANG_COOKIE=dummycookie123
  - CTL_ON_CREATE=join_cluster ejabberd@main
```

## Change Mnesia Node Name

To use the same Mnesia database in a container with a different hostname,
it is necessary to change the old hostname stored in Mnesia.

This section is equivalent to the ejabberd Documentation
[Change Computer Hostname](https://docs.ejabberd.im/admin/guide/managing/#change-computer-hostname),
but particularized to containers that use this
ecs container image from ejabberd 23.01 or older.

### Setup Old Container

Let's assume a container running ejabberd 23.01 (or older) from
this ecs container image, with the database directory binded
and one registered account.
This can be produced with:
```bash
OLDCONTAINER=ejaold
NEWCONTAINER=ejanew

mkdir database
sudo chown 9000:9000 database
docker run -d --name $OLDCONTAINER -p 5222:5222 \
       -v $(pwd)/database:/home/ejabberd/database \
       ejabberd/ecs:23.01
docker exec -it $OLDCONTAINER bin/ejabberdctl started
docker exec -it $OLDCONTAINER bin/ejabberdctl register user1 localhost somepass
docker exec -it $OLDCONTAINER bin/ejabberdctl registered_users localhost
```

Methods to know the Erlang node name:
```bash
ls database/ | grep ejabberd@
docker exec -it $OLDCONTAINER bin/ejabberdctl status
docker exec -it $OLDCONTAINER grep "started in the node" logs/ejabberd.log
```

### Change Mnesia Node

First of all let's store the Erlang node names and paths in variables.
In this example they would be:
```bash
OLDCONTAINER=ejaold
NEWCONTAINER=ejanew
OLDNODE=ejabberd@95145ddee27c
NEWNODE=ejabberd@localhost
OLDFILE=/home/ejabberd/database/old.backup
NEWFILE=/home/ejabberd/database/new.backup
```

1. Start your old container that can still read the Mnesia database correctly.
If you have the Mnesia spool files,
but don't have access to the old container anymore, go to
[Create Temporary Container](#create-temporary-container)
and later come back here.

2. Generate a backup file and check it was created:
```bash
docker exec -it $OLDCONTAINER bin/ejabberdctl backup $OLDFILE
ls -l database/*.backup
```

3. Stop ejabberd:
```bash
docker stop $OLDCONTAINER
```

4. Create the new container. For example:
```bash
docker run \
       --name $NEWCONTAINER \
       -d \
       -p 5222:5222 \
       -v $(pwd)/database:/home/ejabberd/database \
       ejabberd/ecs:latest
```

5. Convert the backup file to new node name:
```bash
docker exec -it $NEWCONTAINER bin/ejabberdctl mnesia_change_nodename $OLDNODE $NEWNODE $OLDFILE $NEWFILE
```

6. Install the backup file as a fallback:
```bash
docker exec -it $NEWCONTAINER bin/ejabberdctl install_fallback $NEWFILE
```

7. Restart the container:
```bash
docker restart $NEWCONTAINER
```

8. Check that the information of the old database is available.
In this example, it should show that the account `user1` is registered:
```bash
docker exec -it $NEWCONTAINER bin/ejabberdctl registered_users localhost
```

9. When the new container is working perfectly with the converted Mnesia database,
you may want to remove the unneeded files:
the old container, the old Mnesia spool files, and the backup files.

### Create Temporary Container

In case the old container that used the Mnesia database is not available anymore,
a temporary container can be created just to read the Mnesia database
and make a backup of it, as explained in the previous section.

This method uses `--hostname` command line argument for docker,
and `ERLANG_NODE_ARG` environment variable for ejabberd.
Their values must be the hostname of your old container
and the Erlang node name of your old ejabberd node.
To know the Erlang node name please check
[Setup Old Container](#setup-old-container).

Command line example:
```bash
OLDHOST=${OLDNODE#*@}
docker run \
       -d \
       --name $OLDCONTAINER \
       --hostname $OLDHOST \
       -p 5222:5222 \
       -v $(pwd)/database:/home/ejabberd/database \
       -e ERLANG_NODE_ARG=$OLDNODE \
       ejabberd/ecs:latest
```

Check the old database content is available:
```bash
docker exec -it $OLDCONTAINER bin/ejabberdctl registered_users localhost
```

Now that you have ejabberd running with access to the Mnesia database,
you can continue with step 2 of previous section
[Change Mnesia Node](#change-mnesia-node).

# Generating ejabberd release

## Configuration

Image is built by embedding an ejabberd Erlang/OTP standalone release in the image.

The configuration of ejabberd Erlang/OTP release is customized with:

- `rel/config.exs`: Customize ejabberd release
- `rel/dev.exs`: ejabberd environment configuration for development release
- `rel/prod.exs`: ejabberd environment configuration for production release
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

# Composer Examples

## Minimal Example

This is the barely minimal file to get a usable ejabberd.
Store it as `docker-compose.yml`:

```yaml
services:
  main:
    image: ejabberd/ecs
    container_name: ejabberd
    ports:
      - "5222:5222"
      - "5269:5269"
      - "5280:5280"
      - "5443:5443"
```

Create and start the container with the command:
```bash
docker-compose up
```

## Customized Example

This example shows the usage of several customizations:
it uses a local configuration file,
stores the mnesia database in a local path,
registers an account when it's created,
and checks the number of registered accounts every time it's started.

Download or copy the ejabberd configuration file:
```bash
wget https://raw.githubusercontent.com/processone/ejabberd/master/ejabberd.yml.example
mv ejabberd.yml.example ejabberd.yml
```

Create the database directory and allow the container access to it:
```bash
mkdir database
sudo chown 9000:9000 database
```

Now write this `docker-compose.yml` file:
```yaml
version: '3.7'

services:

  main:
    image: ejabberd/ecs
    container_name: ejabberd
    environment:
      - CTL_ON_CREATE=register admin localhost asd
      - CTL_ON_START=registered_users localhost ;
                     status
    ports:
      - "5222:5222"
      - "5269:5269"
      - "5280:5280"
      - "5443:5443"
    volumes:
      - ./ejabberd.yml:/home/ejabberd/conf/ejabberd.yml:ro
      - ./database:/home/ejabberd/database
```

## Clustering Example

In this example, the main container is created first.
Once it is fully started and healthy, a second container is created,
and once ejabberd is started in it, it joins the first one.

An account is registered in the first node when created (and
we ignore errors that can happen when doing that - for example
when account already exists),
and it should exist in the second node after join.

Notice that in this example the main container does not have access
to the exterior; the replica exports the ports and can be accessed.

```yaml
version: '3.7'

services:

  main:
    image: ejabberd/ecs
    container_name: main
    environment:
      - ERLANG_NODE_ARG=ejabberd@main
      - ERLANG_COOKIE=dummycookie123
      - CTL_ON_CREATE=! register admin localhost asd
    healthcheck:
      test: netstat -nl | grep -q 5222
      start_period: 5s
      interval: 5s
      timeout: 5s
      retries: 120

  replica:
    image: ejabberd/ecs
    container_name: replica
    depends_on:
      main:
        condition: service_healthy
    ports:
      - "5222:5222"
      - "5269:5269"
      - "5280:5280"
      - "5443:5443"
    environment:
      - ERLANG_NODE_ARG=ejabberd@replica
      - ERLANG_COOKIE=dummycookie123
      - CTL_ON_CREATE=join_cluster ejabberd@main
      - CTL_ON_START=registered_users localhost ;
                     status
```
