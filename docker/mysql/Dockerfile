#8.0
FROM mysql:5.7

MAINTAINER vitams

COPY ./bitrix.cnf /etc/mysql/conf.d/


RUN /usr/bin/mysql &&\
echo "CREATE USER 'bitrix'@'localhost' IDENTIFIED BY 'bitrix-123';
      GRANT ALL PRIVILEGES ON *.* TO 'username'@'localhost' WITH GRANT OPTION;
      CREATE USER 'bitrix'@'%' IDENTIFIED BY 'bitrix-123';
      GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' WITH GRANT OPTION;
      FLUSH PRIVILEGES;" | mysql

#RUN /usr/bin/mysql & \
#sleep 10s &&\
#echo "GRANT ALL ON *.* TO bitrix@'%' IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql



RUN usermod -u 1000 www-data

CMD ["mysqld"]

EXPOSE 3306