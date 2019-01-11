#!/bin/bash

function check_mysql_db(){
	DB_NAME=$1
	DB_USER=$2
	DB_PASSWORD=$3
	MYSQL_CONTAINER_NAME=$(getNeedValue $4 "mysql")
	RES=$(docker exec -i ${MYSQL_CONTAINER_NAME} mysql -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} -e "SHOW DATABASES LIKE '${DB_NAME}';")
	if [ -n "${RES}" ]; then
	    echo "Y"
	else
	    echo "N"
	fi
}

function check_mysql_empty_db(){
	DB_NAME=$1
	DB_USER=$2
	DB_PASSWORD=$3
	MYSQL_CONTAINER_NAME=$(getNeedValue "$4" "mysql")
	RES=$(docker exec -i ${MYSQL_CONTAINER_NAME} mysql -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} -e "use '${DB_NAME}'; show tables like 'b_user';")
	if [ -n "${RES}" ]; then
	    echo "Y"
	else
	    echo "N"
	fi
}

function getNeedValue(){
    CHECK_VALUE=$1
    DEFAULT_VALUE=$2
    if [[ -n "$CHECK_VALUE" ]]; then
        echo $CHECK_VALUE
    else
        echo $DEFAULT_VALUE
    fi
}
