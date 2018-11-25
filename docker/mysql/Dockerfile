#8.0
FROM mysql:5.7

MAINTAINER vitams

COPY ./bitrix.cnf /etc/mysql/conf.d/


#RUN /usr/bin/mysql & \
#sleep 10s &&\
#echo "GRANT ALL ON *.* TO bitrix@'%' IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | #mysql

RUN usermod -u 1000 www-data

CMD ["mysqld"]

EXPOSE 3306