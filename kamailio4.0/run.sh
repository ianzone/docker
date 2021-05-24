#!/bin/bash -e
FLAGS=${1:-"-td"}
NETWORK=${NETWORK:-"kazoo"}
NAME=kamailio.$NETWORK

if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
   echo -n "stopping: "
   docker stop -t 1 $NAME
   echo -n "removing: "
   docker rm -f $NAME
fi
echo -n "starting: $NAME "

COMMIT=$(cat ./kamailio4.0/etc/commit) > /dev/null || true
if [ "$COMMIT" == "" ]
then
    COMMIT=$(cat ./etc/commit)
fi

docker run -itd \
    --net $NETWORK \
    -h $NAME \
    --name $NAME \
    --env NETWORK=$NETWORK \
    --env COUCHDB=couchdb.$NETWORK \
    --env RABBITMQ=rabbitmq.$NETWORK \
    -p 5060:5060 \
    -p 5060:5060/udp \
    kazoo/kamailio:$COMMIT
