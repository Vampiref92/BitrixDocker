#!/bin/bash

PROJECT_NAME="docsfera"
HOME_FOLDER="/home/user"

GIT_PROJECT_DIR="${HOME_FOLDER}/PhpStormProjects/docksferaProjects/${PROJECT_NAME}"
BITRIX_PROJECT_DIR="${HOME_FOLDER}/bitrixFiles/${PROJECT_NAME}/bitrix"
UPLOAD_PROJECT_DIR="${HOME_FOLDER}/bitrixFiles/${PROJECT_NAME}/upload"
VENDOR_PROJECT_DIR="${HOME_FOLDER}/bitrixFiles/${PROJECT_NAME}/vendor"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#останавливаем локальные службы
sudo service apache2 stop
sudo service nginx stop
sudo service mysql stop

sudo systemctl stop apache2
sudo systemctl stop nginx
sudo systemctl stop mysql

#останавливаем все контейнеры
#docker stop $(docker ps -a -q)

cd ${DIR}
find './logs' -type f -delete
find './tmp' -type f -delete
sudo chmod -R 777 ./logs
sudo chmod -R 777 ./htdocs
sudo chmod -R 777 ./tmp


#стартуем докер
cd ./docker && docker-compose up --build --remove-orphans -d ; docker-compose ps

#монтируем проект только после поднятие контейнера php
cd ../htdocs
folder_name="web"
grep_path="${PROJECT_NAME}/htdocs/${folder_name}"
res=`mount | grep "${grep_path}"`
if [ "${res}" ]; then
	echo "${GIT_PROJECT_DIR} is already mounted"
else
	sudo mount --bind ${GIT_PROJECT_DIR} ./${folder_name}
	echo "The directory ${GIT_PROJECT_DIR} is mounted!"
fi 
cd ./${folder_name}

folder_name="bitrix"
grep_path="${PROJECT_NAME}/htdocs/web/${folder_name}"
if ! [ -d ./${folder_name} ]; then
   mkdir ${folder_name}
fi
res=`mount | grep "${grep_path}"`
if [ "${res}" ]; then
	echo "${BITRIX_PROJECT_DIR} is already mounted"
else
	sudo mount --bind ${BITRIX_PROJECT_DIR} ./${folder_name}
	echo "The directory ${BITRIX_PROJECT_DIR} is mounted!"
fi 

folder_name="upload"
grep_path="${PROJECT_NAME}/htdocs/web/${folder_name}"
if ! [ -d ./${folder_name} ]; then
   mkdir ${folder_name}
fi
res=`mount | grep "${grep_path}"`
if [ "${res}" ]; then
	echo "${UPLOAD_PROJECT_DIR} is already mounted"
else
	sudo mount --bind ${UPLOAD_PROJECT_DIR} ./${folder_name}
	echo "The directory ${UPLOAD_PROJECT_DIR} is mounted!"
fi 

folder_name="vendor"
grep_path="${PROJECT_NAME}/htdocs/web/${folder_name}"
if ! [ -d ./${folder_name} ]; then
   mkdir ${folder_name}
fi
res=`mount | grep "${grep_path}"`
if [ "${res}" ]; then
	echo "${VENDOR_PROJECT_DIR} is already mounted"
else
	sudo mount --bind ${VENDOR_PROJECT_DIR} ./${folder_name}
	echo "The directory ${VENDOR_PROJECT_DIR} is mounted!"
fi 
