# UI

This folder contains an example docker-compose file and instructions on bringing up the ESB via docker-compose.

## Setup

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
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