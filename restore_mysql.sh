#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MYSQL_CONTAINER_NAME="mysql"
PATH_TO_BACKUP="/home/frolov/bitrixFiles/toplivnye-karty/bitrix.sql"

. ./.env

# проверяем есть ли БД, если нет то создаем
DB="$(docker exec -i ${MYSQL_CONTAINER_NAME} mysql -uroot -e 'SHOW DATABASES')"
if(  ${DB} =~ ${MYSQL_DATABASE}); then
    PASSWORD_S="";
    if( ! -n ${MYSQL_ROOT_PASSWORD}); then
        PASSWORD_S=" -p${MYSQL_ROOT_PASSWORD}"
    fi
    CREATE DATABASE ${MYSQL_DATABASE} | docker exec -i ${MYSQL_CONTAINER_NAME} mysql -uroot ${PASSWORD_S};
    CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost'  WITH GRANT OPTION;
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost'  WITH GRANT OPTION;
    FLUSH PRIVILEGES;
fi;

#стартуем докер
cat ${PATH_TO_BACKUP} | docker exec -i ${MYSQL_CONTAINER_NAME} mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE}
#cat ${PATH_TO_BACKUP} | docker exec -i ${MYSQL_CONTAINER_NAME} mysql -uroot ${MYSQL_DATABASE}
