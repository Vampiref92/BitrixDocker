FROM "php:7.3-fpm"
ENV PHP_VERSION_NUMBER="7.3"

MAINTAINER vampiref92

ADD ./php.ini /etc/php/${PHP_VERSION_NUMBER}/fpm/conf.d/90-php.ini
ADD ./php.ini /etc/php/${PHP_VERSION_NUMBER}/cli/conf.d/90-php.ini

RUN usermod -u 1000 www-data

WORKDIR "/var/www/bitrix"

EXPOSE 9000