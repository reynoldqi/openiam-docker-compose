#!/bin/bash

set -e

sudo docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
sudo docker pull openiamdocker/circleci_build_utils:latest
sudo docker run -dit openiamdocker/circleci_build_utils:latest
sudo docker cp $(docker ps -a -q -n 1):/opt/openiam/webapps/ /tmp/
sudo cp -r /tmp/webapps/scripts/*.sh /usr/local/bin/

cd ../
sudo chown -R circleci /home/circleci/.docker/
/bin/sh setup.sh
/bin/sh startup.sh

sudo /bin/bash /usr/local/bin/check_health.sh ui 30
sudo /bin/bash /usr/local/bin/check_health.sh esb 30