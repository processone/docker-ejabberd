## Docker image for ejabberd developers

Thanks to this image, you can build ejabberd with dependencies provided in Docker image, without the need to install build software (despite Docker) directly on your own machine.

Please note that this image can likely be reused as is to build other Erlang or Elixir software.

### Building ejabberd from source 

You can build ejabberd from source with all dependencies, with the following commands:

```bash
git clone https://github.com/processone/ejabberd.git
docker run --rm -v $(pwd):$(pwd) -w $(pwd) ejabberd/mix do deps.get, deps.compile, compile
```

## Run ejabberd with mix command-line tool attached

```bash
docker run --rm -it -p 5222:5222 -p 5280:5280 -v $(pwd):$(pwd) -w $(pwd) --entrypoint="/usr/bin/iex" ejabberd/mix -S mix
```

You can then create a user from Elixir and connect with an XMPP client.

## Get into the container

If you want to run Erlang command line, you can do so by opening a shell inside the container:

```bash
docker run -it -v $(pwd):$(pwd) -w $(pwd) --entrypoint="/bin/sh" ejabberd/mix
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

