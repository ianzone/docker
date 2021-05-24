#!/bin/bash

docker rm -f `docker ps -a | grep "kazoo/" | awk '{print $1}'`