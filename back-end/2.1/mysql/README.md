# ESB

This folder contains an example docker-compose file and instructions on bringing up the ESB via docker-compose.

The database used in this example is MySQL, which will be brought up in a separate docker container

## Setup

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$MYSQL_ROOT_PASSWORD - this is the root password that will be used to setup MySQL.  Don't worry, this stays internal to the MySQL docker container
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
```

## Running docker-compose

To bring up the Back-end, run the following commands
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