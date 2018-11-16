#!/bin/sh

set -e

fcitx &
sleep 1

exec "$@"
