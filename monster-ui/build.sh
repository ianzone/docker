#!/bin/sh -e
NETWORK="kazoo"
REPO="https://github.com/2600hz/monster-ui.git"

COMMIT=$(cat etc/commit)

[ -e ./apps ] && APPS=$(cat apps)

docker build $BUILD_FLAGS \
	-t $NETWORK/monster-ui:$COMMIT \
	--build-arg APPS="$APPS" \
	--build-arg TOKEN=$TOKEN \
	--build-arg REPO=$REPO .
