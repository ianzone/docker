#!/bin/sh
export NETWORK="kazoo"
echo -n "starting network: $NETWORK "
docker network create $NETWORK

rabbitmq/run.sh
couchdb/run.sh

kazoo/run.sh
kamailio4.0/run.sh
freeswitch/run.sh

monster-ui/run.sh
