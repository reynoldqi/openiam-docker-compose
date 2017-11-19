#!/bin/bash

set -e

sudo docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
sudo docker pull openiamdocker/circleci_build_utils:latest
sudo docker run -dit openiamdocker/circleci_build_utils:latest
sudo docker cp $(docker ps -a -q -n 1):/opt/openiam/webapps/ /tmp/
sudo cp -r /tmp/webapps/scripts/*.sh /usr/local/bin/