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
```
Чтобы проверить, что все сервисы запустились посмотрите список процессов ```docker ps```.  
Посмотрите все прослушиваемые порты, должны быть 80, 11211, 9000 ```netstat -plnt```.  
Откройте IP машины в браузере.

## Примечание
- Если вы хотите начать с чистой установки Битрикса, скачайте файл [bitrixsetup.php](http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php) в папку с сайтом. По умолчанию стоит папка ```/var/www/bitrix/```
- В настройках подключения требуется указывать имя сервиса, например для подключения к mysql нужно указывать "mysql", а не "localhost". Пример [конфига](configs/.settings.php)  с подклчюением к mysql и memcached.
- Для загрузки резервной копии в контейнер используйте команду: ```cat /var/www/bitrix/backup.sql | docker exec -i mysql /usr/bin/mysql -u root -p123 bitrix```

### Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

### Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE

## Отличие от виртуальной машины Битрикс
Виртуальная машина от разработчиков битрикс решает ту же задачу, что и BitrixDock - предоставляет готовое окружение. Разница лишь в том, что Docker намного удобнее, проще и легче в поддержке.

Как только вы запускаете виртуалку, Docker сервисы автоматически стартуют, т.е. вы запускаете свой минихостинг для проекта и он сразу доступен.

Если у вас появится новый проект и поменяется окружение, достаточно скопировать чистую виртуалку (если вы на винде), скопировать папку BitrixDock, добавить или заменить сервисы и запустить.

## Запуск генерации орм в докере
docker exec -it php php bitrix/bitrix.php orm:annotate -m b24connector,bitrixcloud,blog,clouds,compression,fileman,highloadblock,landing,main,messageservice,mobileapp,perfmon,photogallery,rest,scale,search,security,seo,socialservices,subscribe,translate,ui,vote

## Composer
Composer усанавливает как обычно

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
