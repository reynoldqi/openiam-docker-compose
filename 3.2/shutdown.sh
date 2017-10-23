#!/usr/bin/env bash

set -x
set -e


docker stack rm traefik
docker stack rm ui
docker stack rm openiam
docker stack rm redis
docker stack rm rabbitmq
docker stack rm elasticsearch
docker stack rm mariadb

sleep 5

if [[ "$(docker network ls | grep openiam)" ]]; then
	docker network rm openiam
	sleep 5
fi
