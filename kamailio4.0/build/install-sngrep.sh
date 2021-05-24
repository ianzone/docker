#!/bin/sh -e

echo deb http://packages.irontec.com/debian jessie main >> /etc/apt/sources.list

wget http://packages.irontec.com/public.key -q -O - | apt-key add -

apt-get update

apt-get install sngrep -y