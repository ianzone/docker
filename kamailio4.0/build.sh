#!/bin/sh -e
NETWORK=${NETWORK:-"kazoo"}
COMMIT=$(cat etc/commit)
REPO=${2:-"https://github.com/kamailio/kamailio.git"}
docker build $BUILD_FLAGS --build-arg REPO=$REPO -t $NETWORK/kamailio:$COMMIT .