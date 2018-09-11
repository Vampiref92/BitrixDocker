FROM php:5.6-fpm
ENV PHP_VERSION_NUMBER="5.6"

WORKDIR "/var/www/bitrix"

MAINTAINER vampiref92

RUN apt-get update && apt-get install -y \
curl \
wget \
git \
libfreetype6-dev \
libjpeg62-turbo-dev \
libxslt-dev \
libicu-dev \
libmcrypt-dev \
libpng-dev \
libxml2-dev \
libssl-dev \
freetype* \
&& docker-php-ext-install -j$(nproc) iconv mcrypt mbstring mysqli pdo_mysql zip json ftp zip\
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get update \
  && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo \
    libfreetype6 \
    #libicu52 \
    fontconfig \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxcb1 \
    xfonts-base \
    libfontconfig1 \
    fontconfig-config \
    libx11-data \
    libxau6 \
    libxdmcp6 \
    xfonts-75dpi \
    xfonts-utils \
    ucf \
    fonts-dejavu-core \
    ttf-bitstream-vera \
    fonts-liberation \
    libexpat1 \
    libfontenc1 \
    libxfont1 \
    x11-common \
    xfonts-encodings \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/wkhtmltox-setup \
    && cd /tmp/wkhtmltox-setup \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && cp wkhtmltox/bin/wkhtmltopdf /usr/local/bin/ \
    && rm -rf /tmp/wkhtmltox-setup

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
RUN docker-php-ext-install xsl
RUN docker-php-ext-install soap

COPY php-fpm.d/                     /etc/php/${PHP_VERSION_NUMBER}/fpm/pool.d/
COPY conf.d/                        /etc/php/${PHP_VERSION_NUMBER}/fpm/conf.d/
COPY conf.d/                        /etc/php/${PHP_VERSION_NUMBER}/cli/conf.d/

RUN usermod -u 1000 www-data

EXPOSE 9000
