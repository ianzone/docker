#!/bin/sh -e

git clone https://github.com/freeswitch/spandsp
cd spandsp
./bootstrap.sh -j
./configure -C
make install
cd ..

git clone https://github.com/freeswitch/sofia-sip
cd sofia-sip
./bootstrap.sh -j
./configure -C
make install
cd ..

echo /home/user/spandsp/src/.libs/ >> /etc/ld.so.conf
echo /home/user/spandsp/src/.libs/ >> /etc/ld.so.conf
ldconfig

cd freeswitch
./bootstrap.sh -j
./configure -C
