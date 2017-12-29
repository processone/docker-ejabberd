#!/bin/sh
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- ejabberd "$@"
fi

case "$1" in
    'ejabberd') exec $HOME/bin/ejabberd foreground ;;
    'console') exec $HOME/bin/ejabberd console ;;
    *) exit ;;
esac
