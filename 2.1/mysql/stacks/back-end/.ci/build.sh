#!/bin/bash

set -e

. ../run.sh

sudo chown -R circleci /home/circleci/.docker/
sudo /bin/bash /usr/local/bin/check_health.sh esb 30
sudo /bin/bash /usr/local/bin/check_health.sh idm 30
sudo /bin/bash /usr/local/bin/check_health.sh groovy_manager 30
sudo /bin/bash /usr/local/bin/check_health.sh workflow 30