#!/bin/bash

set -e

docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
docker pull openiamdocker/circleci_build_utils:latest
docker run -dit openiamdocker/circleci_build_utils:latest
docker cp $(docker ps -a -q -n 1):/opt/openiam/webapps/ /tmp/
cp -r /tmp/webapps/scripts/*.sh /usr/local/bin/

cd $1
docker-compose pull
docker-compose up -d
/bin/bash /usr/local/bin/check_health.sh $2 15