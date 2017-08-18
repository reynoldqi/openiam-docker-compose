#!/usr/bin/env bash

set -x
set -e

# setup environment variables
export NODE_ROLE=manager
export DISK_DRIVER=local
export OPENIAM_VERSION_NUMBER="4.0.0"
export BUILD_ENVIRONMENT="dev"
export REDIS_PASSWORD="passwd00"
export MYSQL_ROOT_PASSWORD="passwd00"
export MARIADB_BASE_IMAGE_TYPE="debian"

# setup volumes
docker stack deploy --compose-file metadata/docker-compose.yaml --with-registry-auth openiam-elasticsearch-storage
docker stack deploy --compose-file metadata/docker-compose.yaml --with-registry-auth openiam-mysql-storage
docker stack deploy --compose-file metadata/docker-compose.yaml --with-registry-auth openiam-db-storage
docker stack deploy --compose-file metadata/docker-compose.yaml --with-registry-auth openiam-jks-storage
docker stack deploy --compose-file metadata/docker-compose.yaml --with-registry-auth openiam-activiti-storage
docker stack deploy --compose-file metadata/docker-compose.yaml --with-registry-auth openiam-rabbitmq-storage

# deploy infrastructure services
docker stack deploy --compose-file infrastructure/redis/docker-compose.yaml --with-registry-auth redis
docker stack deploy --compose-file infrastructure/elasticsearch/docker-compose.yaml --with-registry-auth elasticsearch
docker stack deploy --compose-file infrastructure/mariadb/docker-compose.yaml --with-registry-auth mariadb
docker stack deploy --compose-file infrastructure/rabbitmq/docker-compose.yaml --with-registry-auth rabbitmq

# deploy the OpenIAM Stack
docker stack deploy --compose-file services/docker-compose.yaml --with-registry-auth openiam

# Deploy traefik
docker stack deploy --compose-file infrastructure/traefik/docker-compose.yaml --with-registry-auth traefik

