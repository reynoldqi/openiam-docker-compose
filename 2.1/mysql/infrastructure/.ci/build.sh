#!/bin/bash

set -e

. ../run.sh

sudo chown -R circleci /home/circleci/.docker/
sudo /bin/bash /usr/local/bin/check_health.sh redis 30
sudo /bin/bash /usr/local/bin/check_health.sh mariadb 30
sudo /bin/bash /usr/local/bin/check_health.sh elasticsearch 30
sudo /bin/bash /usr/local/bin/check_health.sh rabbitmq 30