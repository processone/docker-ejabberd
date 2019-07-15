
[![Docker Stars](https://img.shields.io/docker/stars/ejabberd/mix.svg)](https://hub.docker.com/r/ejabberd/mix/)
[![Docker Pulls](https://img.shields.io/docker/pulls/ejabberd/mix.svg)](https://hub.docker.com/r/ejabberd/mix/)
[![](https://images.microbadger.com/badges/version/ejabberd/mix.svg)](https://microbadger.com/images/ejabberd/mix)
[![](https://images.microbadger.com/badges/image/ejabberd/mix.svg)](https://microbadger.com/images/ejabberd/mix)
[![GitHub stars](https://img.shields.io/github/stars/processone/docker-ejabberd.svg?style=social)](https://github.com/processone/docker-ejabberd)

## Docker image for ejabberd developers

Thanks to this image, you can build ejabberd with dependencies provided in Docker image, without the need to install build software (beside Docker) directly on your own machine.

Please note that this image can likely be reused as is to build other Erlang or Elixir software.

### Building ejabberd from source 

You can build ejabberd from source with all dependencies, with the following commands:

```bash
git clone https://github.com/processone/ejabberd.git
cd ejabberd
docker run --rm -v $(pwd):$(pwd) -w $(pwd) ejabberd/mix do deps.get, deps.compile, compile
```

Alternatively if you do not have Git installed, you can do:
```bash
wget https://github.com/processone/ejabberd/archive/master.zip
unzip master.zip
cd ejabberd-master
docker run --rm -v $(pwd):$(pwd) -w $(pwd) ejabberd/mix do deps.get, deps.compile, compile
```

## Run ejabberd with mix command-line tool attached

You need to copy default configuration, and can edit it to customize your setup.
As a default, you can run ejabberd with console attached on "localhost" domain:

```bash
cp ejabberd.yml.example config/ejabberd.yml
docker run --rm -it -p 5222:5222 -p 5280:5280 -v $(pwd):$(pwd) -w $(pwd) --entrypoint="/usr/bin/iex" ejabberd/mix -S mix
```

You can then create a user from Elixir shell:

```bash

Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:2:2] [async-threads:10] [kernel-poll:false]
Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> :ejabberd_auth.try_register("test", "localhost", "passw0rd")
{:atomic, :ok}
```

You can then connect with user test@localhost (password: passw0rd) on server on localhost port 5222 and use those parameters to connect with an XMPP client.

## Get into the container

If you want to run Erlang command line, you can do so by opening a shell inside the container:

```bash
docker run -it -v $(pwd):$(pwd) -w $(pwd) --entrypoint="/bin/sh" ejabberd/mix
```

## Getting Elixir version

```bash
docker run -it --rm -v $(pwd):$(pwd) -w $(pwd) ejabberd/mix --version
Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:2:2] [async-threads:10] [kernel-poll:false]

Mix 1.3.4
```

## Build the image

Building the image is not needed if you simply want to use it. You can simply use the one from [ejabberd Docker Hub](https://hub.docker.com/u/ejabberd/dashboard/).

```bash
docker build -t ejabberd/mix .
```

## Troubleshooting

### Clock resync

If you have warning about file timestamp being out of sync (Like 'Clock skew detected'), you may want to force resync your clock before running the build. Docker on MacOS does not force clock resync of Docker after the laptop went to sleep.

You can force clock resync as follow:

```bash
docker run -it  --rm --privileged --entrypoint="/sbin/hwclock" ejabberd/mix -s
```

You can check if the clock of your laptop is in sync with the one inside Docker with the following command:

```bash
docker run --rm --entrypoint="/bin/sh" ejabberd/mix -c date -u && date -u
```

