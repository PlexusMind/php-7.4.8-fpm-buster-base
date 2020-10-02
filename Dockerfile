FROM php:7.4.8-fpm-buster
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt update -y && apt-get -y update && apt-get -y install aptitude
RUN aptitude -o APT::Get::Fix-Missing=true -y install libpng-dev libzip-dev zip unzip curl nano iputils-ping curl nginx less elinks software-properties-common apt-transport-https lsb-release ca-certificates wget libmcrypt-dev git mcrypt libmcrypt-dev

RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

RUN pecl install mcrypt-1.0.3
RUN docker-php-ext-install gd mysqli pdo_mysql  zip bcmath sockets
RUN docker-php-ext-enable gd mysqli pdo_mysql mcrypt bcmath sockets
RUN apt install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install apt-transport-https -y




RUN sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /usr/local/etc/php-fpm.d/www.conf
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=off" >> //usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.max_nesting_level=300000" >> //usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini
