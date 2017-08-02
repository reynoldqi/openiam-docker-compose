#!/bin/bash

set -e

cd ~/project/back-end/2.1/mysql
docker-compose pull

cd ~/project/one-tier/2.1/mysql
docker-compose pull

cd ~/project/ui/2.1/mysql
docker-compose pull