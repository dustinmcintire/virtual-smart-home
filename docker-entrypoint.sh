#!/bin/bash
set -e

if [ "$1" = 'virtual-smart-home' ]; then
    source /.env
    serverless deploy
elif [ "$1" = 'shell' ]; then
    /bin/bash
else
    exec "$@"
fi

