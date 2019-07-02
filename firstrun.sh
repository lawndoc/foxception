#!/bin/bash

[[ -f /tmp/.X1-lock ]] && rm /tmp/.X1-lock && echo "X1-lock found, deleting"

if [ ! "$EDGE" = "1" ]; then
  echo "EDGE not requested, keeping current version"
else
  echo "EDGE requested, updating to latest version"
  echo "This may take a couple of minutes..."
  apt-get install --only-upgrade -y firefox
  echo "Upgrade finished."
fi

echo "Commencing boot..."
