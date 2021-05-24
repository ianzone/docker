#!/bin/sh -e
NETWORK="kazoo"
VERSION=$(cat etc/version)

BACKUP=Dockerfile_build_backup

cp Dockerfile $BACKUP

sed -i "s|{VERSION}|$VERSION|g" Dockerfile

docker build $BUILD_FLAGS -t $NETWORK/couchdb:$VERSION .

mv $BACKUP Dockerfile
