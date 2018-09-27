#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}

. ./.env
. ./manage-etc-hosts.sh

docker-compose stop

removehost ${DOMAIN}
sudo ip a delete ${INTERFACE}/24 dev lo
