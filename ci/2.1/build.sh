#!/bin/bash

set -e

sudo docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
sudo docker pull openiamdocker/circleci_build_utils:latest
sudo docker run -dit openiamdocker/circleci_build_utils:latest
sudo docker cp $(docker ps -a -q -n 1):/opt/openiam/webapps/ /tmp/
sudo cp -r /tmp/webapps/scripts/*.sh /usr/local/bin/

cd $1
docker-compose pull
docker-compose up -d
sudo /bin/bash /usr/local/bin/check_health.sh $2 15