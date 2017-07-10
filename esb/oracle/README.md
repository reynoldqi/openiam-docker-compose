# ESB

This folder contains an example docker-compose file, running against Oracle, and instructions on bringing up the ESB via docker-compose.

## Setup

The following environment variables are required.

```
$BUILD_ENVIRONMENT - this the OpenIAM environment which you are pulling.  Valid values are 'dev', 'qa', and 'prod'
$REDIS_PASSWORD - this is the password that will be used to communicate with Redis.
```

The following environemnt variables are required to run the ESB container

```
$OPENIAM_ORACLE_TIMEZONE - this is required.  Docker has no timezone by default, so you have to specify this for connection to Oracle to work
$OPENIAM_ORACLE_JDBC_URL - the JDBC url to the OpenIAM database
$OPENIAM_ORACLE_JDBC_USERNAME - username to the OpenIAM database
$OPENIAM_ORACLE_JDBC_PASSWORD - password to the OpenIAM database
```

The following environemnt variables are required to run the Workflow container

```
$OPENIAM_ORACLE_TIMEZONE - this is required.  Docker has no timezone by default, so you have to specify this for connection to Oracle to work
$OPENIAM_ORACLE_ACTIVITI_JDBC_URL= the JDBC url to the Activiti Database
$OPENIAM_ORACLE_ACTIVITI_JDBC_USERNAME - the username to the Activiti Database
$OPENIAM_ORACLE_ACTIVITI_JDBC_PASSWORD - the password to the Activiti Database
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