#!/bin/bash

set -e

cd ../
sudo -E docker-compose pull
sudo -E docker-compose up -d

sudo chown -R circleci /home/circleci/.docker/
sudo /bin/bash /usr/local/bin/check_health.sh esb 30
sudo /bin/bash /usr/local/bin/check_health.sh mariadb 30