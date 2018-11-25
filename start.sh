#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}

. ./.env
. ./manage-etc-hosts.sh

sudo ip a add ${INTERFACE}/24 dev lo
addhost ${DOMAIN} ${INTERFACE}

#стартуем докер
# docker network prune
docker-compose up --build --remove-orphans -d ; docker-compose ps
