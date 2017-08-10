# OpenIAM with docker-compose 3.2

This folder contains example docker-compose files to the OpenIAM docker stack(s) to docker swarm 

## Overview

The OpenIAM Suite is broken down into several "stacks", which are deployable to your docker swarm.  Namely:

1) Devops stacks
* Elasticsearch
* Redis
* Mariadb
* RabbitMQ
* Traefik

2) Service stacks
* ESB
* IDM
* Workflow
* Groovy Manager


## System Requirements

This setup has been tested with the following docker and docker-compose versions.  At a minimum, it is recommended that you have these versions of the software

```
docker -v
Docker version 17.06.1-ce-rc1, build 77b4dce

docker-compose -v
docker-compose version 1.14.0, build c7bdf9e
```

## Prerequisites

Firstly, ensure that you have a dockerhub account, and that you are given privileges to download the OpenIAM images.  To request access, please contact your OpenIAM Representative.

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$MYSQL_ROOT_PASSWORD - this is the root password that will be used to setup MySQL.  Don't worry, this stays internal to the MySQL docker container
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
```

The following enviornment variables must be set when running locally.

```
# the Node Role can either be 'worker' or 'manager'.  When deploying to a swarm with multiple nodes, 
# set this to 'worker', or exclude it completely (default is 'worker')
NODE_ROLE=manager

# this is the disk driver to use when writing data to volumes
# valid values are (for example) local, flocker, cloudstor:aws, etc
# this is specific to your needs and environment
DISK_DRIVER=local
```

#### Important

Make sure to initialize your docker swarm:

```
docker swarm init
```

## Setup

To setup (and/or update) your configuration, you can run the setup.sh script.  This will initialize the network, and pull the latest images from our dockerhub.
You can modify the script as required by your internal needs.
 
## Teardown

You can run the shutdown.sh script in order to teardown all openiam stacks, volumes, and networks.

## Running the OpenIAM Stack

We provide a startup.sh script, which can be used to bring up the OpenIAM stacks.  We recommend modifying the environemnt variables at the top of the script, but keeping the docker commands as they are.

#### Important

Make sure that you have run the setup.sh script, and that it has executed *successfully*

Once all containers have been brought up, run the following CURL command to confirm that the Back-end is, indeed, running:

```
curl -L http://localhost/openiam-esb/health
```

The return value of this curl command should be this:
```
{"status":"UP"}
```

## Deploying multiple instances

You can easily control how many instances of a particular service you want to deploy.  Each of our services has the following entry:

```
replicas: 1
```


## Hitting the UI

Hit the following URL in your browser to view the OpenIAM UI:

```
http://localhost.openiam.com/openiam-esb/health
```

Note:  Make sure to put 'localhost.openiam.com' in your hosts file (pointint to 127.0.0.1), and restart your browser after making the hosts file modification (so that changes can take affect)