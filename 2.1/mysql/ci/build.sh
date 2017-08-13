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

sudo chown -R circleci /home/circleci/.docker/
sudo /bin/bash /usr/local/bin/check_health.sh ui 30
sudo /bin/bash /usr/local/bin/check_health.sh esb 30
sudo /bin/bash /usr/local/bin/check_health.sh idm 30
sudo /bin/bash /usr/local/bin/check_health.sh groovy_manager 30
sudo /bin/bash /usr/local/bin/check_health.sh workflow 30
sudo /bin/bash /usr/local/bin/check_health.sh mariadb 30
sudo /bin/bash /usr/local/bin/check_health.sh rabbitmq 30
sudo /bin/bash /usr/local/bin/check_health.sh redis 30