#!/bin/sh -e
export SHM_MEMORY=64
export PKG_MEMORY=8
export USER=kamailio
export GROUP=kamailio

./config-local.sh

FILE_1=/usr/local/lib64/kamailio/sbin/kamailio
FILE_2=/usr/local/sbin/kamailio

exec $FILE_1 -E -DD \
        -P /run/kamailio/kamailio.pid \
        -f /etc/kamailio/kamailio.cfg \
        -m $SHM_MEMORY -M $PKG_MEMORY -u $USER -g $GROUP
