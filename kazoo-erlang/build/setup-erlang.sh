#!/bin/sh -e
curl -O -k https://raw.githubusercontent.com/kerl/kerl/master/kerl
chmod +x kerl
VERSION=$(cat ./version)
./kerl update releases
./kerl build $VERSION $VERSION
./kerl install $VERSION erlang
. erlang/activate
./kerl cleanup all
