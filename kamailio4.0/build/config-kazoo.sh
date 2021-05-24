#!/bin/sh -e
cp -a etc/kamailio /etc/

# git clone https://github.com/2600hz/kazoo-configs-kamailio

# cp  etc/kamailio/kamailio.cfg kazoo-configs-kamailio/kamailio/

# cp -a kazoo-configs-kamailio/kamailio /etc/

# DBENGINE=DBTEXT
# DB_PATH="/etc/kamailio/dbtext"

kamdbctl reinit

sed -i -E  "s/mpath=/#mpath=/g" /etc/kamailio/default.cfg
sed -i -E  's/modparam\("mi_fifo"/#modparam\("mi_fifo"/g' /etc/kamailio/default.cfg

cp /etc/kamailio/local.cfg /etc/kamailio/local.cfg.orig

rsync -av etc/kamailio/dbtext /etc/kamailio/

useradd -d /var/run/kamailio kamailio
