#!/bin/sh -e
NETWORK="kazoo"
REPO="https://github.com/signalwire/freeswitch.git"

COMMIT=$(cat etc/commit)

docker build $BUILD_FLAGS --build-arg REPO=$REPO -t $NETWORK/freeswitch:$COMMIT .
