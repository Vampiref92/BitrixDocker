#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#останавливаем все контейнеры
docker stop $(docker ps -a -q)

cd ${DIR}

#стартуем докер
docker-compose up --build --remove-orphans --force-recreate -d ; docker-compose ps
