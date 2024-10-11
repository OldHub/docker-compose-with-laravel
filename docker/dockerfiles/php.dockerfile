FROM php:8.3-fpm

WORKDIR /var/www

RUN apt-get clean && apt-get update && apt-get install -y zip unzip git nano

RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/bin --filename=composer

RUN docker-php-ext-install pdo_mysql