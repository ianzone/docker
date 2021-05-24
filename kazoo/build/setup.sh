#!/bin/sh -e
if [ -n "$SKIP_BUILD" ]
then
	touch skip_build
	exit 0
fi

. erlang/activate
COMMIT=$(cat ~/commit)
cd kazoo

git reset --hard
git checkout $COMMIT
git clean -d -f


sed -i 's/aba1fa96a4abbbb2c1628ad5d604f482aad4d12f/master/g' make/deps.mk
# sed -i 's|2600hz/erlang-cowboy 2.8.0-OTP19|ninenines/cowboy 2.6.3|g' make/deps.mk
sed -i 's/open("dialcodes.json")/open("dialcodes.json",encoding="utf-8")/g' core/kazoo_numbers/Makefile || true
sed -i 's/open(fn)/open(fn,encoding="utf-8")/g' scripts/format-json.py || true

make deps
