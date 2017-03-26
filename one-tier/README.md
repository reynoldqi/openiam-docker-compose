# One-Tier

This folder contains an example docker-compose file and instructions on bringing up the entire OpenIAM suite via docker-compose.

## Setup

The following environment variables are required.

```
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'dev', 'qa', and 'prod'
$MYSQL_ROOT_PASSWORD - this is the root password that will be used to setup MySQL.  Don't worry, this stays internal to the MySQL docker container
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis. 
```

## Running docker-compose

To bring up the UI, run the following commands
```
docker-compose pull
docker-compose up
```

Once all containers have been brought up, run the following CURL command to confirm that the UI is, indeed, running:

```
curl -L http://localhost:8080/selfservice
```

This should redirect to
```
http://localhost:8080/idp/login.html
```