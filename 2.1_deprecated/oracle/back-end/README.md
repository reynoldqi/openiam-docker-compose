# One-Tier

This folder contains an example docker-compose file and instructions on bringing up the entire OpenIAM suite via docker-compose.

## Setup


The following *additional* environemnt variables are required to run the ESB container, 
in addition to the ones described in the main README

```
$OPENIAM_ORACLE_TIMEZONE - this is required.  Docker has no timezone by default, so you have to specify this for connection to Oracle to work
$OPENIAM_ORACLE_JDBC_URL - the JDBC url to the OpenIAM database
$OPENIAM_ORACLE_JDBC_USERNAME - username to the OpenIAM database
$OPENIAM_ORACLE_JDBC_PASSWORD - password to the OpenIAM database
```

The following environemnt variables are required to run within the Workflow container,
in addition to the ones described in the main README

```
$OPENIAM_ORACLE_TIMEZONE - this is required.  Docker has no timezone by default, so you have to specify this for connection to Oracle to work
$OPENIAM_ORACLE_ACTIVITI_JDBC_URL= the JDBC url to the Activiti Database
$OPENIAM_ORACLE_ACTIVITI_JDBC_USERNAME - the username to the Activiti Database
$OPENIAM_ORACLE_ACTIVITI_JDBC_PASSWORD - the password to the Activiti Database
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