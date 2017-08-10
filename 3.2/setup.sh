#!/usr/bin/env bash

set -x
set -e

export VERSION=${OPENIAM_VERSION_NUMBER:-4.0.0}
export ENVIRONMENT=${BUILD_ENVIRONMENT:-dev}

docker network create --attachable  --driver=overlay openiam

docker pull "openiamdocker/esb:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/workflow:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/idm:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/groovy-manager:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/mariadb:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/redis:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/elasticsearch:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/rabbitmq:${VERSION}-${ENVIRONMENT}"
docker pull "openiamdocker/ui:${VERSION}-${ENVIRONMENT}"