ARG PHP_VERSION
FROM php:${PHP_VERSION}

ARG CONTAINER_PACKAGE_URL
ARG PHP_EXTENSIONS

COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

RUN if [ "${CONTAINER_PACKAGE_URL}" ]; then \
        sed -i "s/\/\/.*debian.org/\/\/${CONTAINER_PACKAGE_URL}/g" /etc/apt/sources.list; \
    fi

RUN if [ "${PHP_EXTENSIONS}" ]; then \
        apt-get update --fix-missing; \
        apt-get -y upgrade; \
        pecl channel-update pecl.php.net; \
    fi
RUN chmod +x install.sh && sh install.sh && rm -fr /tmp/extensions

WORKDIR /www
