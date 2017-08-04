#!/usr/bin/env bash

export NODE_ROLE=manager
export DISK_DRIVER=local
export ENVIRONMENT=local
export OPENIAM_VERSION_NUMBER="4.0.0"
export BUILD_ENVIRONMENT="dev"
export REDIS_PASSWORD="passwd00"
export MYSQL_ROOT_PASSWORD="passwd00"

docker stack rm openiam
if [[ "$(docker network ls | grep openiam)" ]]; then
	docker network rm openiam
fi
docker network create --attachable  --driver=overlay openiam

docker stack deploy --compose-file docker-compose.yaml --with-registry-auth openiam

