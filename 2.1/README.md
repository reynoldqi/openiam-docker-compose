# Infrastructure

This folder contains the necessary information for bringing up the OpenIAM Suite.

## Pre-requisite
Create an account at docker hub and share that account with the OpenIAM Team.
Install the docker client for your OS:

```
https://www.docker.com/docker-centos-distribution 
https://www.docker.com/docker-red-hat-enterprise-linux-rhel
https://www.docker.com/docker-mac 
```

This was tested with:
1) docker -v 1.13.1
2) docker-compose -v 1.14.0

## Setup

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$MYSQL_ROOT_PASSWORD - this is the root password that will be used to setup MySQL.  Don't worry, this stays internal to the MySQL docker container
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
$MARIADB_BASE_IMAGE_TYPE - the type of mariadb base image to use.  Can either by  'alpine' or 'debian'
```

#### !!!Warning!!!

If you are running centos7, set MARIADB_BASE_IMAGE_TYPE to 'debian'.  Failing to do so will result in permissions errors.

## Running docker-compose

To bring up the infrastructure images, run the following commands
```
./start.sh
```

Please change the environment variables at the top, based on your requirements

Wait for the containers to come up, *and for the healthcheck to be 'healthy'*.  
You can view the health status of each container by issuing

```
docker ps
```

##### Important

If this is the very *first* launch, the ESB service *may* fail if the database has not yet been initialized.
This is a known race condition.  To fix this, either:
1) Run ./start.sh again once the mariadb comes up
2) Use swarm mode (see the 3.2 parent folder).

## Updating existing containers
```
./start.sh
```

## Troubleshooting
When troubleshooting with an OpenIAM Engineer, please include the output of the following.
1) docker ps
2) docker -v
3) docker-compose -v
4) env (exclude any sensitive data)
5) docker logs <id_of_containers_with_non_healthy_healthcheck>