#!/bin/bash -e
NETWORK="kazoo"
NAME="freeswitch.$NETWORK"
KAMAILIO="kamailio.$NETWORK"

if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
   echo -n "stopping: "
   docker stop -t 1 $NAME
   echo -n "removing: "
   docker rm -f $NAME
fi

COMMIT=$(cat ./freeswitch/etc/commit) > /dev/null || true
if [ "$COMMIT" == "" ]
then
    COMMIT=$(cat ./etc/commit)
fi

echo -n "starting: $NAME "
docker run -itd \
    --net $NETWORK \
    -h $NAME \
    --name $NAME \
    --env RABBITMQ="rabbitmq.$NETWORK" \
    -p 5080:5080 \
    kazoo/freeswitch:$COMMIT

echo -n "adding dispatcher $NAME to kamailio $KAMAILIO "
docker exec $KAMAILIO dispatcher_add.sh 1 $NAME
