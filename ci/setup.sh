#!/bin/bash

set -e
set -x

export DOCKER_COMPOSE_VERSION="1.14.0"

# make user sudoer
sudo usermod -aG sudo circleci

# remove mysql
sudo apt-get remove mysql

sudo apt-get install -y curl bash git wget unzip

# install docker
# see https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository
sudo apt-get remove docker docker-engine docker.io
sudo rm -rf /usr/local/bin/docker-compose*
sudo apt-get update
sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable edge"
sudo apt-get update
sudo apt-get install docker-ce
# curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" > /tmp/docker-compose
# sudo cp /tmp/docker-compose /usr/local/bin/docker-compose
# sudo chmod a+x /usr/local/bin/docker-compose
sudo apt-get install python-pip
sudo pip install docker-compose
am