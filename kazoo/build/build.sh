#!/bin/bash -e
[ -n "$SKIP_BUILD" ] && exit 0
. erlang/activate
cd kazoo

cp ../sys.config rel/

if [ "$VERSION" == "4.3" ]
then
    cp /tmp/sup.erl core/sup/src/sup.erl
fi

make compile build-dev-release

touch ../skip_build