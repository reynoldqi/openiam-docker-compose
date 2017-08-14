# One-Tier

This folder contains an example docker-compose file and instructions on bringing up the OpenIAM UI via docker-compose.

## Pre-requisite
Create an account at docker hub and share that account with the OpenIAM Team.
Install the docker client for your OS:

```
https://www.docker.com/docker-centos-distribution 
https://www.docker.com/docker-red-hat-enterprise-linux-rhel
https://www.docker.com/docker-mac 
```

## Setup

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
$ESB_HOST - the host the ESB
$ESB_PORT - the port of the ESB
```

## Running docker-compose

To bring up the Suite, run the following commands
```
docker-compose pull
docker-compose up
```

This should redirect to
```
http://localhost:8080/idp/login.html
```

## Updating existing containers
```
sudo docker-compose pull
sudo docker-compose up
```
Wait for the containers to come up.

## Troubleshooting - Option 1
```
sudo docker ps -a | grep esb
sudo docker logs --since="10m" <id from above > /tmp/openiam-support.log
sudo docker ps (send the output of this to the OpenIAM engineer)
```
Email the openiam-support.log to the OpenIAM engineer who is helping you.

## Troubleshooting - Option 2
In case we need to troubleshoot further, use the steps below:
```
docker -v (send me this output)
docker-compose -v (send me this output)
docker rm $(docker ps -a -q) -f
docker-compose pull (send me this output)
docker-compose up (send me this output - it might be tricky to get this all into one file, but please do this)
wait ~5 minutes.  in another shell:  docker ps -a (send me this output)
env (send me this output)
send me the docker-compose.yaml file that you're using.
log into the ESB container
cat /data/openiam/conf/rabbitmq.properties (send me this output)
docker logs -f <id_of_running_esb_container> > /tmp/openiam-support.rabbitmq.out.  Send me /tmp/openiam-support.rabbitmq.out
```
In the comments above which indicate - Send me the logs - Please those logs to the OpenIAM engineer who is helping you or create a ticket at support.openiam.com and attach these logs