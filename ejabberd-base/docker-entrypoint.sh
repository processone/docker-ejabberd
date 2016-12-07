#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- ejabberd "$@"
fi

if [ "$1" = 'ejabberd' ]; then
	mkdir -p "$P1DATA"
	chmod 700 "$P1DATA"
	chown -R p1 "$P1DATA"
	mkdir -p "$P1LOG"
	chmod 700 "$P1LOG"
	chown -R p1 "$P1LOG"

	su-exec p1 $HOME/ejabberd/bin/ejabberd foreground
fi

if [ "$1" = 'console' ]; then
	mkdir -p "$P1DATA"
	chmod 700 "$P1DATA"
	chown -R p1 "$P1DATA"
	mkdir -p "$P1LOG"
	chmod 700 "$P1LOG"
	chown -R p1 "$P1LOG"

	su-exec p1 $HOME/ejabberd/bin/ejabberd console
fi
