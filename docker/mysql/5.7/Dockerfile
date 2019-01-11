#8.0
FROM mysql:5.7

MAINTAINER vitams

COPY ./bitrix.cnf /etc/mysql/conf.d/

RUN usermod -u 1000 www-data

ADD data/init.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]

EXPOSE 3306
