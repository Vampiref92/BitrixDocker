#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}
cd ./docker && docker-compose stop

#Размонтируем проект
#cd ../htdocs/web
#sudo umount -l ./vendor
#sudo umount -l ./upload
#sudo umount -l ./bitrix
#cd ..
#sudo umount -l ./web

#останавливаем все контейнеры
#docker stop $(docker ps -a -q)

#запускаем локальные службы
sudo service apache2 start
sudo service nginx start
sudo service mysql start
