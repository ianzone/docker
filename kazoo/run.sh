#!/bin/bash -e
NETWORK="kazoo"
NAME="kazoo.$NETWORK"

if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
    echo -n "stopping: "
    docker stop -t 1 $NAME
    echo -n "removing: "
    docker rm -f $NAME
fi

if [ -n "$KAZOO_SOURCE" ]
then
    [ ! -e "$KAZOO_SOURCE" ] && echo "Kazoo source tree set to $KAZOO_SOURCE, but not accessible" && exit 1
    KAZOO_SOURCE_VOLUME="-v $KAZOO_SOURCE:/home/user/kazoo"
    echo See \"docker logs $NAME\" output
fi

COMMIT=$(cat ./kazoo/etc/commit) > /dev/null || true
if [ "$COMMIT" == "" ]
then
    COMMIT=$(cat ./etc/commit)
fi

echo -n "starting: $NAME "
docker run -itd $KAZOO_SOURCE_VOLUME \
    --net $NETWORK \
    -h $NAME \
    --name $NAME \
    -p 8000:8000 \
    --env NETWORK=$NETWORK \
    --env COUCHDB=couchdb.$NETWORK \
    --env RABBITMQ=rabbitmq.$NETWORK \
    --env NODE_NAME=kazoo \
    --env KAZOO_APPS=sysconf,blackhole,callflow,cdr,conference,crossbar,fax,hangups,media_mgr,milliwatt,omnipresence,pivot,registrar,reorder,stepswitch,teletype,trunkstore,webhooks,ecallmgr \
    $NETWORK/kazoo:$COMMIT
