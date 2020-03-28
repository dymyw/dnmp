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

export EXTENSIONS=",${PHP_EXTENSIONS},"

#
# Install the extension using the *.tgz file downloaded from PECL
#
installByTgz()
{
    tgzName=$1
    extensionName="${tgzName%%-*}"

    mkdir ${extensionName}
    tar -xzf ${tgzName}.tgz -C ${extensionName} --strip-components=1
    ( cd ${extensionName} && phpize && ./configure && make ${MC} && make install )

    docker-php-ext-enable ${extensionName}
}

if [ -z "${EXTENSIONS##*,amqp,*}" ]; then
    echo "-------- Install amqp --------"
    apt-get -y install --no-install-recommends librabbitmq-dev
    installByTgz amqp-1.9.3
fi

if [ -z "${EXTENSIONS##*,bcmath,*}" ]; then
    echo "-------- Install bcmath --------"
    docker-php-ext-install ${MC} bcmath
fi

if [ -z "${EXTENSIONS##*,bz2,*}" ]; then
    echo "-------- Install bz2 --------"
    apt-get -y install --no-install-recommends libbz2-dev
    docker-php-ext-install ${MC} bz2
fi

if [ -z "${EXTENSIONS##*,calendar,*}" ]; then
    echo "-------- Install calendar --------"
    docker-php-ext-install ${MC} calendar
fi

if [ -z "${EXTENSIONS##*,curl,*}" ]; then
    echo "-------- curl is installed --------"
fi

if [ -z "${EXTENSIONS##*,enchant,*}" ]; then
    echo "-------- Install enchant --------"
    apt-get -y install --no-install-recommends libenchant-dev
    docker-php-ext-install ${MC} enchant
fi

if [ -z "${EXTENSIONS##*,exif,*}" ]; then
    echo "-------- Install exif --------"
    docker-php-ext-install ${MC} exif
fi

if [ -z "${EXTENSIONS##*,gd,*}" ]; then
    echo "-------- Install gd --------"
    apt-get -y install --no-install-recommends \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev
    docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
    docker-php-ext-install ${MC} gd
fi

if [ -z "${EXTENSIONS##*,gettext,*}" ]; then
    echo "-------- Install gettext --------"
    docker-php-ext-install ${MC} gettext
fi

if [ -z "${EXTENSIONS##*,gmp,*}" ]; then
    echo "-------- Install gmp --------"
    apt-get -y install --no-install-recommends libgmp-dev
    docker-php-ext-install ${MC} gmp
fi

if [ -z "${EXTENSIONS##*,imagick,*}" ]; then
    echo "-------- Install imagick --------"
    apt-get -y install --no-install-recommends libmagickwand-dev
    pecl install imagick-3.4.4
    docker-php-ext-enable imagick
fi

if [ -z "${EXTENSIONS##*,imap,*}" ]; then
    echo "-------- Install imap --------"
    apt-get -y install --no-install-recommends \
        libc-client-dev libkrb5-dev
    docker-php-ext-configure \
        imap --with-kerberos --with-imap-ssl
    docker-php-ext-install ${MC} imap
fi

if [ -z "${EXTENSIONS##*,interbase,*}" ]; then
    echo "-------- Install interbase --------"
    apt-get -y install --no-install-recommends \
        firebird-dev libib-util
    docker-php-ext-install ${MC} interbase
fi

if [ -z "${EXTENSIONS##*,intl,*}" ]; then
    echo "-------- Install intl --------"
    apt-get -y install --no-install-recommends libicu-dev
    docker-php-ext-install ${MC} intl
fi

if [ -z "${EXTENSIONS##*,ldap,*}" ]; then
    echo "-------- Install ldap --------"
    apt-get -y install --no-install-recommends libldap2-dev
    docker-php-ext-install ${MC} ldap
fi

if [ -z "${EXTENSIONS##*,mbstring,*}" ]; then
    echo "-------- mbstring is installed --------"
fi

# mcrypt has been deprecated in 7.1 and removed in 7.2 in favor of OpenSSL
#   https://secure.php.net/manual/en/migration71.deprecated.php
#   https://lukasmestan.com/install-mcrypt-extension-in-php7-2/
if [ -z "${EXTENSIONS##*,mcrypt,*}" ]; then
    echo "-------- mcrypt is installed --------"
fi

if [ -z "${EXTENSIONS##*,memcached,*}" ]; then
    echo "-------- Install memcached --------"
    apt-get -y install --no-install-recommends \
        libmemcached-dev zlib1g-dev
    pecl install memcached-3.1.3
    docker-php-ext-enable memcached
fi

if [ -z "${EXTENSIONS##*,mongodb,*}" ]; then
    echo "-------- Install mongodb --------"
    pecl install mongodb-1.5.3
    docker-php-ext-enable mongodb
fi

if [ -z "${EXTENSIONS##*,msgpack,*}" ]; then
    echo "-------- Install msgpack --------"
    pecl install msgpack-2.0.3
    docker-php-ext-enable msgpack
fi

if [ -z "${EXTENSIONS##*,mysqli,*}" ]; then
    echo "-------- Install mysqli --------"
    docker-php-ext-install ${MC} mysqli
fi

if [ -z "${EXTENSIONS##*,opcache,*}" ]; then
    echo "-------- Install opcache --------"
    docker-php-ext-install ${MC} opcache
fi

if [ -z "${EXTENSIONS##*,pcntl,*}" ]; then
    echo "-------- Install pcntl --------"
    docker-php-ext-install ${MC} pcntl
fi

if [ -z "${EXTENSIONS##*,pdo_mysql,*}" ]; then
    echo "-------- Install pdo_mysql --------"
    docker-php-ext-install ${MC} pdo_mysql
fi

if [ -z "${EXTENSIONS##*,pdo_odbc,*}" ]; then
    echo "-------- Install pdo_odbc --------"
    apt-get -y install --no-install-recommends unixodbc-dev
    docker-php-ext-configure \
        pdo_odbc --with-pdo-odbc=unixODBC,/usr
    docker-php-ext-install ${MC} pdo_odbc
fi

if [ -z "${EXTENSIONS##*,pdo_pgsql,*}" ]; then
    echo "-------- Install pdo_pgsql --------"
    apt-get -y install --no-install-recommends libpq-dev
    docker-php-ext-install ${MC} pdo_pgsql
fi

if [ -z "${EXTENSIONS##*,pdo_sqlsrv,*}" ]; then
    echo "-------- Install pdo_sqlsrv --------"
    apt-get -y install --no-install-recommends unixodbc-dev
    pecl install pdo_sqlsrv-5.6.1
    docker-php-ext-enable pdo_sqlsrv
fi

if [ -z "${EXTENSIONS##*,pgsql,*}" ]; then
    echo "-------- Install pgsql --------"
    apt-get -y install --no-install-recommends libpq-dev
    docker-php-ext-install ${MC} pgsql
fi

if [ -z "${EXTENSIONS##*,pspell,*}" ]; then
    echo "-------- Install pspell --------"
    apt-get -y install --no-install-recommends libpspell-dev
    docker-php-ext-install ${MC} pspell
fi

if [ -z "${EXTENSIONS##*,readline,*}" ]; then
    echo "-------- curl is readline --------"
fi

if [ -z "${EXTENSIONS##*,recode,*}" ]; then
    echo "-------- Install recode --------"
    apt-get -y install --no-install-recommends librecode-dev
    docker-php-ext-install ${MC} recode
fi

if [ -z "${EXTENSIONS##*,redis,*}" ]; then
    echo "-------- Install redis --------"
    installByTgz redis-5.0.0
fi

if [ -z "${EXTENSIONS##*,shmop,*}" ]; then
    echo "-------- Install shmop --------"
    docker-php-ext-install ${MC} shmop
fi

if [ -z "${EXTENSIONS##*,snmp,*}" ]; then
    echo "-------- Install snmp --------"
    apt-get -y install --no-install-recommends libsnmp-dev
    docker-php-ext-install ${MC} snmp
fi

if [ -z "${EXTENSIONS##*,soap,*}" ]; then
    echo "-------- Install soap --------"
    apt-get -y install --no-install-recommends libxml2-dev
    docker-php-ext-install ${MC} soap
fi

if [ -z "${EXTENSIONS##*,sockets,*}" ]; then
    echo "-------- Install sockets --------"
    docker-php-ext-install ${MC} sockets
fi

if [ -z "${EXTENSIONS##*,swoole,*}" ]; then
    echo "-------- Install swoole --------"
    installByTgz swoole-4.4.16
fi

if [ -z "${EXTENSIONS##*,sysvmsg,*}" ]; then
    echo "-------- Install sysvmsg --------"
    docker-php-ext-install ${MC} sysvmsg
fi

if [ -z "${EXTENSIONS##*,sysvsem,*}" ]; then
    echo "-------- Install sysvsem --------"
    docker-php-ext-install ${MC} sysvsem
fi

if [ -z "${EXTENSIONS##*,sysvshm,*}" ]; then
    echo "-------- Install sysvshm --------"
    docker-php-ext-install ${MC} sysvshm
fi

if [ -z "${EXTENSIONS##*,tidy,*}" ]; then
    echo "-------- Install tidy --------"
    apt-get -y install --no-install-recommends libtidy-dev
    docker-php-ext-install ${MC} tidy
fi

if [ -z "${EXTENSIONS##*,wddx,*}" ]; then
    echo "-------- Install wddx --------"
    apt-get -y install --no-install-recommends libxml2-dev
    docker-php-ext-install ${MC} wddx
fi

if [ -z "${EXTENSIONS##*,xmlrpc,*}" ]; then
    echo "-------- Install xmlrpc --------"
    apt-get -y install --no-install-recommends libxml2-dev
    docker-php-ext-install ${MC} xmlrpc
fi

if [ -z "${EXTENSIONS##*,xdebug,*}" ]; then
    echo "-------- Install xdebug --------"
    installByTgz xdebug-2.6.0
fi

if [ -z "${EXTENSIONS##*,xhprof,*}" ]; then
    echo "-------- Install xhprof --------"
    mkdir xhprof-2.1.0
    tar -xzf xhprof-2.1.0.tar.gz -C xhprof-2.1.0 --strip-components=1
    ( cd xhprof-2.1.0/extension && phpize && ./configure && make ${MC} && make install )
    docker-php-ext-enable xhprof
fi

if [ -z "${EXTENSIONS##*,xsl,*}" ]; then
    echo "-------- Install xsl --------"
    apt-get -y install --no-install-recommends libxslt-dev
    docker-php-ext-install ${MC} xsl
fi

if [ -z "${EXTENSIONS##*,yac,*}" ]; then
    echo "-------- Install yac --------"
    pecl install yac-2.0.2
    docker-php-ext-enable yac
fi

if [ -z "${EXTENSIONS##*,yaconf,*}" ]; then
    echo "-------- Install yaconf --------"
    pecl install yaconf-1.0.7
    docker-php-ext-enable yaconf
fi

if [ -z "${EXTENSIONS##*,yaf,*}" ]; then
    echo "-------- Install yaf --------"
    installByTgz yaf-3.0.8
fi

if [ -z "${EXTENSIONS##*,zend_test,*}" ]; then
    echo "-------- Install zend_test --------"
    docker-php-ext-install ${MC} zend_test
fi

if [ -z "${EXTENSIONS##*,zip,*}" ]; then
    echo "-------- Install zip --------"
    apt-get -y install --no-install-recommends libzip-dev
    docker-php-ext-install ${MC} zip
fi
