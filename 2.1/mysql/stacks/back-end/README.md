# Back-end

This folder contains an example docker-compose file and instructions on bringing up the OpenIAM back-end via docker-compose.

## Pre-requisite

First, you need to setup the infrastructure to run OpenIAM.  To do this, simply follow the 
instructions in the [infrastructure](../../infrastructure) page


## Setup

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
```

## Running docker-compose

To bring up the Suite, run the following commands
```
docker-compose pull
docker-compose up
```
Once all containers have been brought up, run the following CURL command to confirm that the Back-end is, indeed, running:

```
curl -L http://localhost:9080/openiam-esb/health
```

The return value of this curl command should be this:
```
{"status":"UP"}
```

## Updating existing containers
```
sudo docker-compose pull
sudo docker-compose up
```
Wait for the containers to come up.

## Troubleshooting
When troubleshooting with an OpenIAM Engineer, please include the output of the following.
1) docker ps
2) docker -v
3) docker-compose -v
4) env (exclude any sensitive data)
5) docker logs <id_of_containers_with_non_healthy_healthcheck>