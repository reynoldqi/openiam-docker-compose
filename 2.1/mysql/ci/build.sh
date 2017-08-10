#!/bin/bash

set -e

sudo docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
sudo docker pull openiamdocker/circleci_build_utils:latest
sudo docker run -dit openiamdocker/circleci_build_utils:latest
sudo docker cp $(docker ps -a -q -n 1):/opt/openiam/webapps/ /tmp/
sudo cp -r /tmp/webapps/scripts/*.sh /usr/local/bin/

cd ../
sudo -E docker-compose pull
sudo -E docker-compose up -d

sudo /bin/bash /usr/local/bin/check_health.sh ui 15
sudo /bin/bash /usr/local/bin/check_health.sh esb 15