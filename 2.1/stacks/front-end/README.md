# Back-end

This folder contains an example docker-compose file for bringing up the OpenIAM front-end via docker-compose.

If you are running the front-end in standalone mode (i.e. back-end services on one node, front-end services on another node),
then you need to tell the UI *where* the ESB is.  To do this:


Set the following ENV vars:

```
$ESB_HOST - name of the host where the ESB is running (i.e. esb)
$ESB_PORT - port of the ESB (usually 9080) 
```

Then, uncomment the following int he docker-compose.yaml file:

```
 - "ESB_HOST=${ESB_HOST}"
 - "ESB_PORT=${ESB_PORT}"
```