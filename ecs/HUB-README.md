# ejabberd Community Server Docker Image

## What is ejabberd

[ejabberd][im] is an open-source,
robust, scalable and extensible realtime platform built using [Erlang/OTP][erlang],
that includes [XMPP][xmpp] Server, [MQTT][mqtt] Broker and [SIP][sip] Service.

Check the features in [ejabberd.im][im], [ejabberd Docs][features],
[ejabberd at ProcessOne][p1home], and a list of [supported protocols and XEPs][xeps].

[im]: https://ejabberd.im/
[erlang]: https://www.erlang.org/
[xmpp]: https://xmpp.org/
[mqtt]: https://mqtt.org/
[sip]: https://en.wikipedia.org/wiki/Session_Initiation_Protocol
[features]: https://docs.ejabberd.im/admin/introduction/
[p1home]: https://www.process-one.net/en/ejabberd/
[xeps]: https://www.process-one.net/en/ejabberd/protocols/


## What is `ejabberd/ecs`

This `ejabberd/ecs` Docker image is built for stable ejabberd releases using
[docker-ejabberd/ecs](https://github.com/processone/docker-ejabberd/tree/master/ecs).
It's based in Alpine Linux, and is aimed at providing a simple image to setup and configure.

Please report problems related to this `ejabberd/ecs` image packaging in
[docker-ejabberd Issues](https://github.com/processone/docker-ejabberd/issues),
and general ejabberd problems in
[ejabberd Issues](https://github.com/processone/ejabberd/issues).


## How to use the ejabberd/ecs image

Please check [ejabberd/ecs README](https://github.com/processone/docker-ejabberd/tree/master/ecs#readme)


## Supported Architectures

This `ejabberd/ecs` docker image is built for the `linux/amd64` architecture.


## Alternative Image in GitHub

There is another container image published in
[ejabberd GitHub Packages](https://github.com/processone/ejabberd/pkgs/container/ejabberd),
that you can download from the GitHub Container Registry.

Its usage is similar to this `ejabberd/ecs` image, with some benefits and changes worth noting:

- it's available for `linux/amd64` and `linux/arm64` architectures
- it's built also for `master` branch, in addition to the stable ejabberd releases
- it includes less customizations to the base ejabberd compared to `ejabberd/ecs`
- it stores data in `/opt/ejabberd/` instead of `/home/ejabberd/`

See its documentation in [CONTAINER](https://github.com/processone/ejabberd/blob/master/CONTAINER.md).

