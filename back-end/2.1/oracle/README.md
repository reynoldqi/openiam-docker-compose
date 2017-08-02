# ESB

This folder contains an example docker-compose file, running against Oracle, and instructions on bringing up the ESB via docker-compose.

## Setup

The following environment variables are required.

```
$OPENIAM_VERSION_NUMBER - this is the Version of OpenIAM that you are interested in running.  For Version 4, please use "4.0.0"
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'latest', dev', 'qa', and 'prod'
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
```

The following environemnt variables are required to run both the ESB and Workflow Containers

```
$OPENIAM_ORACLE_TIMEZONE - this is required.  Docker has no timezone by default, so you have to specify this for connection to Oracle to work
$OPENIAM_JDBC_HOST= the JDBC host to the OpenIAM Database
$OPENIAM_JDBC_PORT = the JDBC port to the OpenIAM Database
$OPENIAM_JDBC_SCHEMA_NAME = the JDBC Schema to the OpenIAM Database
$OPENIAM_JDBC_USERNAME - username to the OpenIAM database
$OPENIAM_JDBC_PASSWORD - password to the OpenIAM database
$OPENIAM_ACTIVITI_JDBC_USERNAME - the username to the Activiti Database
$OPENIAM_ACTIVITI_JDBC_PASSWORD - the password to the Activiti Database
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