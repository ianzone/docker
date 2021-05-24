#!/bin/sh -e

# https://docs.2600hz.com/sysadmin/doc/kazoo/ecallmgr-cmd/
# cd kazoo
# watch -g "docker logs kazoo.kazoo | grep 'pool kz_amqp_pool not available yet'" > /dev/null
# ./kazoo/sup kazoo_maintenance console_level debug

NETWORK="kazoo"
echo wait for kazoo.kazoo to start '(you may check docker logs if impatient)'
watch -g "docker logs kazoo.kazoo | grep 'auto-started kapps'" > /dev/null

cd kazoo
echo -n "create master account: "
./sup crossbar_maintenance create_account admin kamailio.$NETWORK admin admin
echo -n "add freeswitch to kazoo: "
./sup ecallmgr_maintenance add_fs_node freeswitch@freeswitch.$NETWORK

echo -n "enable console debug: "
./sup kazoo_maintenance console_level debug

echo wait fot freeswitch to complete connect
watch -g "docker logs kazoo.$NETWORK | grep 'max_channel_cleanup_timeout_ms'" > /dev/null

IP=$(docker inspect --format "{{ .NetworkSettings.Networks.$NETWORK.IPAddress }}" kamailio.$NETWORK)
echo -n "add kamailio to kazoo with ip $IP: "
./sup ecallmgr_maintenance allow_carrier kamailio.$NETWORK $IP

echo import default kazoo sounds
./sup kazoo_media_maintenance import_prompts /home/user/us en-us \
 && docker exec -i --user root kazoo.kazoo rm -rf us

echo enable monster-ui applications
docker cp monster-ui.kazoo:/usr/share/nginx/html/src/apps apps \
 && docker cp apps kazoo.kazoo:/home/user \
 && rm -rf apps \
 && ./sup crossbar_maintenance init_apps /home/user/apps \
 && docker exec -i --user root kazoo.kazoo rm -rf apps

echo refresh kamailio dispatcher
docker exec -i kamailio.$NETWORK kamcmd dispatcher.reload 

echo commit couchdb to couchdb-init
docker commit couchdb.kazoo kazoo/couchdb-init

echo -n "set debug to info: "
./sup kazoo_maintenance console_level debug

cd ../
