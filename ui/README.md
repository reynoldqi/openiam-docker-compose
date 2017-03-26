# UI

This folder contains an example docker-compose file and instructions on bringing up the ESB via docker-compose.

## Setup

The following environment variables are required.

```
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'dev', 'qa', and 'prod'
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
$ESB_PORT - the port that the ESB is running.  If  running thorugh a load balancer, this is likely '80'.  If hitting the ESB directly, this is likely 9080
$ESB_HOST - the host where the ESB is running 
```

##Running docker-compose

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