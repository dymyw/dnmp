#!/bin/sh

export MC="-j$(nproc)"

echo
echo "============================================"
echo "Install extensions script : install.sh"
echo "PHP version               : ${PHP_VERSION}"
echo "Extra Extensions          : ${PHP_EXTENSIONS}"
echo "Multi-core Compilation    : ${MC}"
echo "Container package url     : ${CONTAINER_PACKAGE_URL}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo

if [ -z "${PHP_EXTENSIONS##*amqp*}" ]; then
    echo "-------- Install amqp --------"
    apt-get -y install --no-install-recommends librabbitmq-dev
    pecl install amqp-1.9.3
    docker-php-ext-enable amqp
fi

if [ -z "${PHP_EXTENSIONS##*bz2*}" ]; then
    echo "-------- Install bz2 --------"
    apt-get -y install --no-install-recommends libbz2-dev
    docker-php-ext-install ${MC} bz2
fi

if [ -z "${PHP_EXTENSIONS##*exif*}" ]; then
    echo "-------- Install exif --------"
    docker-php-ext-install ${MC} exif
fi

if [ -z "${PHP_EXTENSIONS##*gd*}" ]; then
    echo "-------- Install gd --------"
    apt-get -y install --no-install-recommends \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev
    docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
    docker-php-ext-install ${MC} gd
fi

if [ -z "${PHP_EXTENSIONS##*gettext*}" ]; then
    echo "-------- Install gettext --------"
    docker-php-ext-install ${MC} gettext
fi

if [ -z "${PHP_EXTENSIONS##*imagick*}" ]; then
    echo "-------- Install imagick --------"
    apt-get -y install --no-install-recommends libmagickwand-dev
    pecl install imagick-3.4.4
    docker-php-ext-enable imagick
fi

if [ -z "${PHP_EXTENSIONS##*imap*}" ]; then
    echo "-------- Install imap --------"
    apt-get -y install --no-install-recommends \
        libc-client-dev libkrb5-dev
    docker-php-ext-configure \
        imap --with-kerberos --with-imap-ssl
    docker-php-ext-install ${MC} imap
fi

# mcrypt has been deprecated in 7.1 and removed in 7.2 in favor of OpenSSL
#   https://secure.php.net/manual/en/migration71.deprecated.php
#   https://lukasmestan.com/install-mcrypt-extension-in-php7-2/

if [ -z "${PHP_EXTENSIONS##*memcached*}" ]; then
    echo "-------- Install memcached --------"
    apt-get -y install --no-install-recommends \
        libmemcached-dev zlib1g-dev
    pecl install memcached-3.1.3
    docker-php-ext-enable memcached
fi

if [ -z "${PHP_EXTENSIONS##*mongodb*}" ]; then
    echo "-------- Install mongodb --------"
    pecl install mongodb-1.5.3
    docker-php-ext-enable mongodb
fi

if [ -z "${PHP_EXTENSIONS##*mysqli*}" ]; then
    echo "-------- Install mysqli --------"
    docker-php-ext-install ${MC} mysqli
fi

if [ -z "${PHP_EXTENSIONS##*pdo_mysql*}" ]; then
    echo "-------- Install pdo_mysql --------"
    docker-php-ext-install ${MC} pdo_mysql
fi

if [ -z "${PHP_EXTENSIONS##*redis*}" ]; then
    echo "-------- Install redis --------"
    pecl install redis-5.0.0
    docker-php-ext-enable redis
fi

if [ -z "${PHP_EXTENSIONS##*sockets*}" ]; then
    echo "-------- Install sockets --------"
    docker-php-ext-install ${MC} sockets
fi

if [ -z "${PHP_EXTENSIONS##*xdebug*}" ]; then
    echo "-------- Install xdebug --------"
    pecl install xdebug-2.6.0
    docker-php-ext-enable xdebug
fi

if [ -z "${PHP_EXTENSIONS##*xhprof*}" ]; then
    echo "-------- Install xhprof --------"
    mkdir xhprof-2.1.0
    tar -xzf xhprof-2.1.0.tar.gz -C xhprof-2.1.0 --strip-components=1
    ( cd xhprof-2.1.0/extension && phpize && ./configure && make && make install )
    docker-php-ext-enable xhprof
fi

if [ -z "${PHP_EXTENSIONS##*yaf*}" ]; then
    echo "-------- Install yaf --------"
    pecl install yaf-3.0.8
    docker-php-ext-enable yaf
fi
