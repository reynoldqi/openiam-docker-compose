#!/bin/bash

set -e

# setup environment variables
export NODE_ROLE=manager
export DISK_DRIVER=local
export OPENIAM_VERSION_NUMBER="4.0.0"
export BUILD_ENVIRONMENT="dev"
export REDIS_PASSWORD="passwd00"
export MYSQL_ROOT_PASSWORD="passwd00"
export MARIADB_BASE_IMAGE_TYPE="debian"

if [[ ! "$(docker network ls | grep openiam)" ]]; then
	docker network create --attachable  --driver=overlay openiam
	sleep 5
fi

docker volume create -d $DISK_DRIVER --name openiam-elasticsearch-storage_storage
docker volume create -d $DISK_DRIVER --name openiam-mysql-storage_storage
docker volume create -d $DISK_DRIVER --name openiam-db-storage_storage
docker volume create -d $DISK_DRIVER --name openiam-jks-storage_storage
docker volume create -d $DISK_DRIVER --name openiam-activiti-storage_storage
docker volume create -d $DISK_DRIVER --name openiam-rabbitmq-storage_storage

echo "==============(Re)Deploying Infrastructure================="
cd infrastructure

cd elasticsearch
docker-compose pull && docker-compose up -d
cd ../

cd mariadb
docker-compose pull && docker-compose up -d
cd ../

cd redis
docker-compose pull && docker-compose up -d
cd ../

cd rabbitmq
docker-compose pull && docker-compose up -d
cd ../

cd ../
echo "==============Finished (Re)Deploying Infrastructure================="


cd stacks
echo "==============(Re)Deploying Back-end services================="

cd back-end
docker-compose pull && docker-compose up -d
cd ../

echo "==============Finished (Re)Deploying Back-end services================="



echo "==============(Re)Deploying Front-end services================="

cd front-end
docker-compose pull && docker-compose up -d
cd ../

echo "==============Finished (Re)Deploying Front-end services================="