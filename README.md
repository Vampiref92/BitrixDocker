![Alt text](assets/logo.jpg?raw=true "BitrixDock")

**За базу взят https://github.com/bitrixdock/bitrixdock**

# BitrixDock
BitrixDock позволяет легко и просто запускать **Bitrix CMS** на **Docker**.

## Зависимости
- Git
```
apt-get install -y git
```
- Docker & Docker-Compose
```
cd /usr/local/src && wget -qO- https://get.docker.com/ | sh && \
curl -L "https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
echo "alias dc='docker-compose'" >> ~/.bash_aliases && \
source ~/.bashrc
```

### Начало работы
- Склонируйте репозиторий
```
git clone https://github.com/Vampiref92/BitrixDocker.git
```

- Выполните настройку окружения

Скопируйте файл `.env_template` в `.env`

```
cp -f .env_template .env
```

По умолчнию используется nginx php7.1, эти настройки можно изменить в файле ```.env```. Также можно задать путь к каталогу с сайтом и параметры базы данных MySQL.


```
PHP_VERSION=7.1           # Версия php 
WEB_SERVER_TYPE=nginx      # Веб-сервер nginx/apache
MYSQL_DATABASE=bitrix      # Имя базы данных
MYSQL_USER=bitrix          # Пользователь базы данных
MYSQL_PASSWORD=123         # Пароль для доступа к базе данных
MYSQL_ROOT_PASSWORD=123    # Пароль для пользователя root от базы данных
MYSQL_VERSION=5.7    # Версия устанавливаемой mysql
INTERFACE=192.168.10.10          # На данный интерфейс будут проксироваться порты - его и открываем в браузере
DOMAIN=site.loc          # локальный домен сайта
SITE_PATH=/var/www/bitrix  # Путь к директории Вашего сайта

```

- Запустите bitrixdock
```
bash start.sh
из проекта
bash ../../start.sh
```
Может понадобиться установить локальные службы
```
bash stop_local.sh
из проекта
bash ../../stop_local.sh
```
Чтобы проверить, что все сервисы запустились посмотрите список процессов ```docker ps```.  
Посмотрите все прослушиваемые порты, должны быть 80, 11211, 9000 ```netstat -plnt```.  
Откройте адрес сайта или ip в браузере.

## Примечание
- Если вы хотите начать с чистой установки Битрикса, скачайте файл [bitrixsetup.php](http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php) в папку с сайтом. По умолчанию стоит папка ```/var/www/bitrix/```
- В настройках подключения требуется указывать имя сервиса, например для подключения к mysql нужно указывать "mysql", а не "localhost". Пример [конфига](configs/.settings.php)  с подклчюением к mysql и memcached.

### Backup
```
docker exec #CONTAINER#(mysql_#PROJECT_NAME#) /usr/bin/mysqldump -u #user#(root) -p#pass#(123) #DATABASE#(bitrix) > backup.sql
```

### Restore
```
cat backup.sql | docker exec -i #CONTAINER#(mysql_#PROJECT_NAME#) /usr/bin/mysql -u #user#(root( -p#pass#(123) #DATABASE#(bitrix)
```

```
zcat backup.sql.gz | docker exec -i #CONTAINER#(mysql_#PROJECT_NAME#) /usr/bin/mysql -u #user#(root) -p#pass#(123) #DATABASE#(bitrix)
```

### Подключение к БД
```
mysql -u #root user# -h #container ip# -P 33061 -p#root password#
```
```
mysql -u root -h 192.168.10.11 -P 33061 -p123
```

## Запуск генерации орм в докере
```
docker exec -it #CONTAINER#(php_#PROJECT_NAME#) php -d memnory_limit=-1 bitrix/bitrix.php orm:annotate -m all
```
Если с ошибками исключаем модули, может получиться примерно так
```
docker exec -it #CONTAINER#(php_#PROJECT_NAME#) php -d memnory_limit=-1 bitrix/bitrix.php orm:annotate -m b24connector,bitrixcloud,blog,clouds,compression,fileman,highloadblock,landing,main,messageservice,mobileapp,perfmon,photogallery,rest,scale,search,security,seo,socialservices,subscribe,translate,ui,vote
```

## Composer
Composer усанавливает через докер:
```
docker exec -it #CONTAINER#(php_#PROJECT_NAME#) bash -c "cd public/local && php -d memory_limit=-1 ./composer.phar install"
```

либо как обычно локально с нужной версией php, например
```
/usr/bin/php7.1 local/composer.phar install
```

## Работа с докером
удаление всех мостов
```
docker network prune
```

https://www.8host.com/blog/udalenie-obrazov-kontejnerov-i-tomov-docker/

удаление всех образов
```
docker rmi $(docker images -a -q)
```

остановка всех контейнеров
```
docker stop $(docker ps -a -q)
```

удаление всех контейнеров
```
docker rm $(docker ps -a -q)
```

Единственную настройку которую нужно поменять в docker-compose.yml это имя newtworks - вместо bitrix прописать то что в project_name