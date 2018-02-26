# OpenIAM with docker

This project contains examples of how to deploy the OpenIAM stack to docker.  We will be deploying in swarm mode, although that is not strictly a requirement.

## Overview

The OpenIAM Suite is broken down into several "stacks", which are deployable to your docker swarm.  Namely:

1) Critical Infrastructure stacks
* Elasticsearch
* Redis
* Mariadb
* RabbitMQ
* Traefik
* Nginx

2) Service stacks
* ESB
* IDM
* Workflow
* Groovy Manager
* Synchronization
3) UI Stack

## Hardware Requirements
It is recommended that you have at least 12G of memory avaialable to run the OpenIAM Stack in docker

## Software System Requirements

This setup has been tested with the following docker and docker-compose versions.  At a minimum, it is recommended that you have these versions of the software

To use docker-compose 3.0 file format, you must have the following docker and docker-compose versions installed

```
1.13.0+
```

To use docker-compose 3.2 file format, you must have (at least) the following docker and docker-compose versions installed 

```
17.04.0+
```

## Prerequisites

Ensure that the docker host(s) have the following value set:

```
sysctl -w vm.max_map_count=262144
```

Add this to:
```
/etc/sysctl.conf
```

to persist across restarts.


Firstly, ensure that you have a dockerhub account, and that you are given privileges to download the OpenIAM images.  To request access, please contact your OpenIAM Representative.

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$MYSQL_ROOT_PASSWORD - this is the root password that will be used to setup MySQL.  Don't worry, this stays internal to the MySQL docker container
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
$MARIADB_BASE_IMAGE_TYPE - the type of mariadb base image to use.  Can either by  'alpine' or 'debian'
$DB_TYPE - the database type to be used.  Valid values are MariaDB, Posgres, MSSQL, or Oracle
```

## Database

#### MariaDB

Make sure to set the DB_TYPE environment variable to 'MariaDB' in setup.sh

```
export DB_TYPE="MariaDB"
```


##### Warning

If you are running centos7, set MARIADB_BASE_IMAGE_TYPE to 'debian'.  Failing to do so will result in permissions errors, which
we have yet to track down the root cause of


#### SQLServer

If you are using MSSQL, you have to tell the ESB and Workflow that you are using that database.  To do this,
include the following environment variables in the services docker-compose.yaml descriptor.

Change the Hibernate Dialect Accordingly to your SQLServer version.
```
      JDBC_HOST: "${JDBC_HOST}" # the hostname of the database
      JDBC_PORT: "${JDBC_PORT}" # port of the database
      JDBC_SCHEMA_NAME: "${JDBC_SCHEMA_NAME}" # openiam database schema (i.e. 'openiam.dbo')
      JDBC_USERNAME: "${JDBC_USERNAME}" # username to the openiam database
      JDBC_PASSWORD: "${JDBC_PASSWORD}" # password to the openiam database
      JDBC_ACTIVITI_USERNAME: "${JDBC_ACTIVITI_USERNAME}" # username to the activiti database
      JDBC_ACTIVITI_PASSWORD: "${JDBC_ACTIVITI_PASSWORD}" # password to the activiti database
      JDBC_DATABASE_NAME: "${JDBC_DATABASE_NAME}" # name of the openiam database (i.e. 'openiam')
      JDBC_ACTIVITI_DATABASE_NAME: "${JDBC_ACTIVITI_DATABASE_NAME}" # name of the activiti database (i.e. 'activiti')
      OPENIAM_HIBERNATE_DIALECT: "org.hibernate.dialect.SQLServer2012Dialect" # hibernate dialect for your SQLServer Version
```

Make sure to set the DB_TYPE environment variable to 'MSSQL' in setup.sh

```
export DB_TYPE="MSSQL"
```

#### Oracle

If you are using Oracle, you have to tell the ESB and Workflow that you are using that database.  To do this,
include the following environment variables in the services docker-compose.yaml descriptor.

Change the Hibernate Dialect Accordingly to your Oracle version
```
      JDBC_HOST: "${JDBC_HOST}" # the hostname of the database
      JDBC_PORT: "${JDBC_PORT}" # port of the database
      JDBC_SID: "${JDBC_SID}" # SID for connecting to your Oracle database
      JDBC_SERVICE_NAME: "${JDBC_SERVICE_NAME}" # Service Name for connecting to your Oracle database
      JDBC_SCHEMA_NAME: "${JDBC_SCHEMA_NAME}" # openiam database schema (i.e. 'IAMUSER')
      JDBC_USERNAME: "${JDBC_USERNAME}" # username to the openiam database
      JDBC_PASSWORD: "${JDBC_PASSWORD}" # password to the openiam database
      JDBC_ACTIVITI_USERNAME: "${JDBC_ACTIVITI_USERNAME}" # username to the activiti database
      JDBC_ACTIVITI_PASSWORD: "${JDBC_ACTIVITI_PASSWORD}" # password to the activiti database
      OPENIAM_PROP_user_timezone: "${ORACLE_USER_TIMEZONE}" # property required by Oracle
      OPENIAM_HIBERNATE_DIALECT: "org.hibernate.dialect.Oracle10gDialect" # hibernate dialect for your Oracle Version
```

If you are using the Oracle SID to connect to Oracle, set the JDBC_SID variable.
If you are using the Oracle Service Name to connect to Oralce, set the JDBC_SERVICE_NAME variable

Make sure to set the DB_TYPE environment variable to 'Oracle' in setup.sh

```
export DB_TYPE="Oracle"
```

## Swarm and Disk Driver Config


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

```
./setup.sh
```

 
## Teardown

You can run the teardown.sh script in order to teardown all openiam stacks, volumes, and networks.

```
./teardown.sh
```


## Startup

We provide a startup.sh script, which can be used to bring up the OpenIAM stacks.  We recommend modifying the environment variables at the top of the script, but keeping the docker commands as they are.
To startup:

```
export DOCKER_COMPOSE_VERSION=3.2 # can also be 2.1
./startup.sh
```

## Shutdown

We provide a shutdown.sh script, which can be used to shut down the OpenIAM stacks (excluding volumes).

```
./shutdown.sh
```

#### Important

Make sure that you have run the setup.sh script, and that it has executed *successfully*

Once all containers have been brought up, run the following CURL command to confirm that the back-end is indeed running:

```
curl -L http://127.0.0.1:8000/openiam-esb/health
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
http://127.0.0.1:8000/webconsole
http://127.0.0.1:8000/selfservice
```

Note that Traefik takes over the "localhost" domain of the environment, 
so you will not be able to use that alias.  In addition, our default configuration has
traefik listening on port 8000.  In a proper deployment, you should have apache load balancer 
in front of traefik, so that port 80 and 443 are forwarded to port 8000


## Using Docker Swarm

By default, the shell scripts that we provide deploy to the docker swarm.
Ensure that the necessary ports are opened.  Otherwise, the manager and worker node(s)
will not be able to communicate with each other.  See the [following](https://docs.docker.com/engine/swarm/swarm-tutorial/) link.
  

## Elasticsearch and Nginx

Nginx is used in our stack to enable autodiscovery of ElasticSearch nodes.
Normally, in a non-swarm enviornment, you would know exactly how many
ElasticSearch nodes you have, enabling you to specify the hostnames in the 'discovery.zen.ping.unicast.hosts'
property.

In swarm mode, this is not possible, as you do not know neither the number of instances, nor
the IP Addresses of the nodes in advance.  To get around this, we use dnsrr network mode, and specify 
a single value for 'discovery.zen.ping.unicast.hosts'.  Pinging of this hostname will resolve
to a different IP Address (i.e. DNS Round Robin), allowing all ElasticSearch instances
to *eventually* find each other.  Nginx allows the discovery request to be proxied from the 
outside world (in case of different docker hosts) into the openiam_private docker network


The [following guide](https://sematext.com/blog/docker-elasticsearch-swarm/) was used as an example
