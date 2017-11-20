#!/bin/bash

set -e

/bin/bash /usr/local/bin/check_health.sh rabbitmq 5
/bin/bash /usr/local/bin/check_health.sh mariadb 5
/bin/bash /usr/local/bin/check_health.sh redis 5

/bin/bash /usr/local/bin/check_health.sh idm 5
/bin/bash /usr/local/bin/check_health.sh groovy_manager 5
/bin/bash /usr/local/bin/check_health.sh workflow 5
/bin/bash /usr/local/bin/check_health.sh esb 30
/bin/bash /usr/local/bin/check_health.sh ui 30