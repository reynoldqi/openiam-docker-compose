#!/usr/bin/env bash

set -x
set -e

export VERSION=${OPENIAM_VERSION_NUMBER:-4.0.0}
export ENVIRONMENT=${BUILD_ENVIRONMENT:-dev}
export MARIADB_BASE_IMAGE_TYPE="debian"

if [[ ! "$(docker network ls | grep openiam_private)" ]]; then
	docker network create --attachable  --driver=overlay openiam_private
	sleep 5
fi

if [[ ! "$(docker network ls | grep openiam_public)" ]]; then
	docker network create --attachable  --driver=overlay openiam_public
	sleep 5
fi

docker pull jwilder/nginx-proxy:alpine
docker pull "openiamdocker/esb:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/workflow:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/idm:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/groovy-manager:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/mariadb:${MARIADB_BASE_IMAGE_TYPE}-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/redis:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/elasticsearch:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/rabbitmq:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/ui:alpine-${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/openiam-metadata:alpine-${VERSION}-${ENVIRONMENT}"