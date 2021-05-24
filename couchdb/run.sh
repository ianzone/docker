#!/bin/bash -e
NETWORK="kazoo"
NAME="couchdb.$NETWORK"

if [ -n "$(docker ps -aq -f name=$NAME)" ]
then
   echo -n "stopping: "
   docker stop -t 1 $NAME
   echo -n "removing: "
   docker rm -f $NAME
fi
echo -n "starting: $NAME "

# COMMIT=$(cat ./etc/version) > /dev/null || true
# if [ "$COMMIT" == "" ]
# then
# 	COMMIT=$(cat ./couchdb/etc/version)
# fi

# docker run -itd \
# 	--net $NETWORK \
# 	-h $NAME \
# 	--name $NAME \
#    -p 5984:5984 \
# 	$NETWORK/couchdb:$COMMIT

VERSION=$(cat ./couchdb/etc/version) > /dev/null || true
if [ "$VERSION" == "" ]
then
   VERSION=$(cat ./etc/version)
fi

docker run -itd \
   --net $NETWORK \
   -h $NAME \
   -e ERL_FLAGS="-name couchdb@$NAME -setcookie change_me" \
   --name $NAME \
   -p 5984:5984 \
   $NETWORK/couchdb:$VERSION