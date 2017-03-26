# ESB

This folder contains an example docker-compose file and instructions on bringing up the ESB via docker-compose.

## Setup

The following environment variables are required.

```
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'dev', 'qa', and 'prod'
$MYSQL_ROOT_PASSWORD - this is the root password that will be used to setup MySQL.  Don't worry, this stays internal to the MySQL docker container
```

## Running docker-compose

To bring up the ESB, run the following commands
```
docker-compose pull
docker-compose up
```

Once all containers have been brought up, run the following CURL command to confirm that the ESB is, indeed, running:

```
curl -L http://localhost:9080/openiam-esb/health
```

The return value of this curl command should be this:
```
{"status":"UP"}
```