#!/bin/bash -e
FLAGS=${1:-"-td"}
NETWORK="kazoo"
NAME="monster-ui.$NETWORK"

if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
   echo -n "stopping: "
   docker stop -t 1 $NAME
   echo -n "removing: "
   docker rm -f $NAME
fi
echo -n "starting: $NAME "

COMMIT=$(cat ./monster-ui/etc/commit) > /dev/null || true
if [ "$COMMIT" == "" ]
then
   COMMIT=$(cat ./etc/commit)
fi

docker run $FLAGS \
   --net $NETWORK \
   -h $NAME \
   --name $NAME \
   -p 3000:3000 \
   -p 3001:3001 \
   kazoo/monster-ui:$COMMIT
