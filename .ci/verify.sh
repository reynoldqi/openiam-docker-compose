#!/bin/bash

set -e
set -x

sudo chown -R circleci /home/circleci/.docker/
sudo /bin/bash /usr/local/bin/check_health.sh elasticsearch 30
sudo /bin/bash /usr/local/bin/check_health.sh rabbitmq 30
sudo /bin/bash /usr/local/bin/check_health.sh mariadb 30
sudo /bin/bash /usr/local/bin/check_health.sh redis 30

sudo /bin/bash /usr/local/bin/check_health.sh idm 30
sudo /bin/bash /usr/local/bin/check_health.sh groovy_manager 30
sudo /bin/bash /usr/local/bin/check_health.sh workflow 30
sudo /bin/bash /usr/local/bin/check_health.sh esb 30