#!/bin/sh -e
COMMIT=$(cat commit)
cd freeswitch
git checkout $COMMIT
