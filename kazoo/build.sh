#!/bin/sh -e
REPO="https://github.com/2600hz/kazoo.git"

BRANCH=${BRANCH:-""}
SKIP_BUILD=${SKIP_BUILD:-""}
NETWORK="kazoo"

UID=$(id -u)
GID=$(id -g)

VERSION=$(cat ../kazoo-erlang/etc/version)

BACKUP=Dockerfile_build_backup
cp Dockerfile $BACKUP
sed -i "s|{VERSION}|$VERSION|g" Dockerfile

COMMIT=$(cat ./etc/commit)

docker build $BUILD_FLAGS -t $NETWORK/kazoo:$COMMIT \
	--build-arg REPO=$REPO \
	--build-arg SKIP_BUILD=$SKIP_BUILD \
	--build-arg UID=$UID \
	--build-arg GID=$GID \
	--build-arg BRANCH=$BRANCH \
	--build-arg VERSION=$VERSION \
	.

mv $BACKUP Dockerfile