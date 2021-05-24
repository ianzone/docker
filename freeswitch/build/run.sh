#!/bin/bash -e
epmd -daemon
exec /usr/local/freeswitch/bin/freeswitch -nf
