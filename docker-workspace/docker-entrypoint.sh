#!/bin/sh

set -e

eval $(gpg-agent)

fcitx &
sleep 1

# set env vars
export INSIDE_DOCKER=t

exec "$@"
