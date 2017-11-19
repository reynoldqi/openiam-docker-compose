#!/bin/bash

set -e

export OPENIAM_VERSION_NUMBER="4.0.0"
export BUILD_ENVIRONMENT="dev"
export REDIS_PASSWORD="passwd00"
export MYSQL_ROOT_PASSWORD="passwd00"
export MARIADB_BASE_IMAGE_TYPE="debian"

sudo docker-compose pull
sudo docker-compose up -d