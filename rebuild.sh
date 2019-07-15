#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}

. ./.env
. ./manage-etc-hosts.sh

docker-compose stop

removehost ${DOMAIN}
sudo ip a delete ${INTERFACE}/24 dev lo

# стопаем все запущенные контейнеры
docker stop $(docker ps -a -q)
# удаляем все контейнеры
docker rm $(docker ps -a -q)
# удаляем все нетворки
docker network prune -f

sudo ip a add ${INTERFACE}/24 dev lo
addhost ${DOMAIN} ${INTERFACE}

#стартуем докер
docker-compose up --build --remove-orphans --force-recreate -d ; docker-compose ps
