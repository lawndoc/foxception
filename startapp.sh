#!/usr/bin/env bash

# remove X1-lock if it exists
[[ -f /tmp/.X1-lock ]] && rm /tmp/.X1-lock && echo "X1-lock found, deleting"
# update to latest firefox version
apt-get install --only-upgrade -y firefox

# start firefox and restart if closed
while true
do
	/usr/bin/firefox $START_URL
done
