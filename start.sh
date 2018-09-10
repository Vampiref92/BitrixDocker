#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${DIR}

#стартуем докер
docker-compose up --build --remove-orphans -d ; docker-compose ps
