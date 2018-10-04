FROM php:7.2-fpm-stretch
MAINTAINER alex.shcneider@gmail.com

RUN apt-get update && \
    apt-get install -y curl git libmemcached-dev zlib1g-dev unzip zip

RUN docker-php-ext-install mysqli opcache pdo_mysql zip

RUN set -ex && \
    pecl install APCu && \
    pecl install memcached && \
    pecl install redis && \
    pecl install xdebug && \
    docker-php-ext-enable apcu redis memcached xdebug

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

RUN apt-get autoremove && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*
