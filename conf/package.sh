#!/bin/bash

set -e
set -x

cd ~/project/back-end/2.1/mysql
sudo docker-compose pull

cd ~/project/one-tier/2.1/mysql
sudo docker-compose pull

cd ~/project/ui/2.1/mysql
sudo docker-compose pull