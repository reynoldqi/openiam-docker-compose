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
docker stack rm openiam-elasticsearch-storage
docker stack rm openiam-mysql-storage
docker stack rm openiam-db-storage
docker stack rm openiam-jks-storage
docker stack rm openiam-activiti-storage

#docker rm $(docker ps -a -q) -f
sleep 5

if [[ "$(docker volume ls | grep openiam-elasticsearch-storage_storage)" ]]; then
	docker volume rm openiam-elasticsearch-storage_storage
	sleep 5
fi
if [[ "$(docker volume ls | grep openiam-elasticsearch-storage)" ]]; then
	docker volume rm openiam-elasticsearch-storage
	sleep 5
fi

if [[ "$(docker volume ls | grep openiam-mysql-storage_storage)" ]]; then
	docker volume rm openiam-mysql-storage_storage
	sleep 5
fi
if [[ "$(docker volume ls | grep openiam-mysql-storage)" ]]; then
	docker volume rm openiam-mysql-storage
	sleep 5
fi

if [[ "$(docker volume ls | grep openiam-db-storage_storage)" ]]; then
	docker volume rm openiam-db-storage_storage
	sleep 5
fi
if [[ "$(docker volume ls | grep openiam-db-storage)" ]]; then
	docker volume rm openiam-db-storage
	sleep 5
fi

if [[ "$(docker volume ls | grep openiam-jks-storage_storage)" ]]; then
	docker volume rm openiam-jks-storage_storage
	sleep 5
fi
if [[ "$(docker volume ls | grep openiam-jks-storage)" ]]; then
	docker volume rm openiam-jks-storage
	sleep 5
fi

if [[ "$(docker volume ls | grep openiam-activiti-storage_storage)" ]]; then
	docker volume rm openiam-activiti-storage_storage
	sleep 5
fi
if [[ "$(docker volume ls | grep openiam-activiti-storage)" ]]; then
	docker volume rm openiam-activiti-storage
	sleep 5
fi

if [[ "$(docker network ls | grep openiam)" ]]; then
	docker network rm openiam
	sleep 5
fi
