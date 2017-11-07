#!/bin/bash

CONTAINER_IDS=`docker ps -q`
CONTAINER_IPS=`docker ps -q | xargs -n 1 docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' | tail -n +1`

for ip in $CONTAINER_IPS; do
  echo "Joining: $ip to block chain cluster"
  curl -d host=${ip} http://localhost:80/network/join
done
