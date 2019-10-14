ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG CONTAINER_PACKAGE_URL

COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ]; then \
        sed -i "s/\/\/.*debian.org/\/\/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list; \
    fi

RUN apt-get update --fix-missing && apt-get -y upgrade

# bz2
#RUN apt-get -y install --no-install-recommends \
#        libbz2-dev \
#    && docker-php-ext-install -j$(nproc) bz2

# exif
#RUN docker-php-ext-install -j$(nproc) exif

# gd
#RUN apt-get -y install --no-install-recommends \
#        libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev \
#    && docker-php-ext-configure \
#        gd --with-gd --with-webp-dir --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
#    && docker-php-ext-install -j$(nproc) gd

# gettext
#RUN docker-php-ext-install -j$(nproc) gettext

# imap
#RUN apt-get -y install --no-install-recommends \
#        libc-client-dev libkrb5-dev \
#    && docker-php-ext-configure \
#        imap --with-kerberos --with-imap-ssl \
#    && docker-php-ext-install -j$(nproc) imap

# mcrypt has been deprecated in 7.1 and removed in 7.2 in favor of OpenSSL
#   https://secure.php.net/manual/en/migration71.deprecated.php
#   https://lukasmestan.com/install-mcrypt-extension-in-php7-2/

# mysqli
#RUN docker-php-ext-install -j$(nproc) mysqli

# pdo_mysql
#RUN docker-php-ext-install -j$(nproc) pdo_mysql

# sockets
#RUN docker-php-ext-install -j$(nproc) sockets

#
# pecl
#
RUN pecl channel-update pecl.php.net

# amqp
#RUN apt-get -y install --no-install-recommends \
#        librabbitmq-dev \
#    && pecl install amqp-1.9.3 \
#    && docker-php-ext-enable amqp

# imagick
#RUN apt-get -y install --no-install-recommends \
#        libmagickwand-dev \
#    && pecl install imagick-3.4.4 \
#    && docker-php-ext-enable imagick

# memcached
#RUN apt-get -y install --no-install-recommends \
#        libmemcached-dev zlib1g-dev \
#    && pecl install memcached-3.1.3 \
#    && docker-php-ext-enable memcached

# mongodb
#RUN pecl install mongodb-1.5.3 \
#    && docker-php-ext-enable mongodb

# redis
#RUN pecl install redis-5.0.0 \
#    && docker-php-ext-enable redis

# xdebug
#RUN pecl install xdebug-2.6.0 \
#    && docker-php-ext-enable xdebug

# yaf
#RUN pecl install yaf-3.0.8 \
#    && docker-php-ext-enable yaf

#
# source code
#
#RUN mkdir xhprof-2.1.0 \
#    && tar -xzf xhprof-2.1.0.tar.gz -C xhprof-2.1.0 --strip-components=1 \
#    && ( cd xhprof-2.1.0/extension && phpize && ./configure && make && make install ) \
#    && docker-php-ext-enable xhprof

RUN rm -rf /tmp/extensions

COPY conf.d /usr/local/etc/php/conf.d/

WORKDIR /www
