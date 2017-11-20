#!/bin/bash

set -e

/bin/bash /usr/local/bin/check_health.sh elasticsearch 30
/bin/bash /usr/local/bin/check_health.sh rabbitmq 30
/bin/bash /usr/local/bin/check_health.sh mariadb 30
/bin/bash /usr/local/bin/check_health.sh redis 30

/bin/bash /usr/local/bin/check_health.sh idm 30
/bin/bash /usr/local/bin/check_health.sh groovy_manager 30
/bin/bash /usr/local/bin/check_health.sh workflow 30
/bin/bash /usr/local/bin/check_health.sh esb 30