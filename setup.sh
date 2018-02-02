#!/usr/bin/env bash

set -x
set -e

export VERSION=${OPENIAM_VERSION_NUMBER:-4.0.0}
export ENVIRONMENT=${BUILD_ENVIRONMENT:-dev}
export MARIADB_BASE_IMAGE_TYPE="debian"

if [[ ! "$(docker network ls | grep openiam)" ]]; then
	docker network create --attachable  --driver=overlay openiam
	sleep 5
fi

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