#!/bin/sh -e
NETWORK="kazoo"
VERSION=$(cat ./etc/version)
docker build $BUILD_FLAGS -t $NETWORK/erlang:$VERSION .
