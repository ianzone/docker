#!/bin/bash -e
FLAGS=${1:-"-td"}
NETWORK="kazoo" 
NAME="rabbitmq.$NETWORK"
if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
	echo -n "stopping: "
	docker stop -t 1 $NAME
	echo -n "removing: "
	docker rm -f $NAME
fi
echo -n "starting: $NAME "
docker run $FLAGS \
	--net $NETWORK \
	-h $NAME \
	-e RABBITMQ_ERLANG_COOKIE='change_me' \
	-e RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS='-setcookie change_me' \
	--name $NAME \
	kazoo/rabbitmq
