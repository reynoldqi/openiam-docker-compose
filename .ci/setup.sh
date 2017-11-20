#!/bin/bash

set -e
set -x

docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
docker pull openiamdocker/circleci_build_utils:latest
docker run -dit openiamdocker/circleci_build_utils:latest
docker cp $(docker ps -a -q -n 1):/opt/openiam/webapps/ /tmp/
cp -r /tmp/webapps/scripts/*.sh /usr/local/bin/