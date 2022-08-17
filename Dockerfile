# Secure and Minimal image of Php.
# https://hub.docker.com/repository/docker/huggla/sam-php

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.6-3.16"
ARG IMAGETYPE="application,base"
ARG MAKEDIRS="/etc/php81/conf.d /etc/php81/php-fpm.d"
ARG RUNDEPS="\
#        php81 \
#        php81-bcmath \
        php81-dom \
#        php81-ctype \
        php81-curl \
#        php81-fileinfo \
        php81-fpm \
#        php81-gd \
#        php81-iconv \
        php81-intl \
        php81-json \
        php81-mbstring \
        php81-mcrypt \
#        php81-mysqlnd \
        php81-opcache \
        php81-openssl \
#        php81-pdo \
#        php81-pdo_mysql \
#        php81-pdo_pgsql \
#        php81-pdo_sqlite \
#        php81-phar \
#        php81-posix \
        php81-simplexml \
        php81-session \
#        php81-soap \
#        php81-tokenizer \
#        php81-xml \
#        php81-xmlreader \
#        php81-xmlwriter \
#        php81-zip \
        php81-pgsql \
        php81-pecl-imagick \
#        libpng \
#        libpng-static \
#        libpng-utils \
#        libjpeg-turbo \
#        imagemagick \
#        curl \
        php81-pecl-apcu \
        php81-ldap"
#        composer"
ARG STARTUPEXECUTABLES="/usr/sbin/php-fpm81"
ARG REMOVEFILES="/etc/php81/php-fpm.d/www.conf"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as base
FROM ${INITIMAGE:-scratch} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-build} as build
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_LINUX_USER="php" \
    VAR_FINAL_COMMAND="php-fpm81 --nodaemonize --force-stderr" \
    VAR_SOCKET_FILE="/run/php81-fpm/socket" \
    VAR_LOG_FILE="/var/log/php81/error.log" \
    VAR_wwwconf_listen='$VAR_SOCKET_FILE' \
    VAR_wwwconf_pm="dynamic" \
    VAR_wwwconf_pm__max_children="5" \
    VAR_wwwconf_pm__min_spare_servers="1" \
    VAR_wwwconf_pm__max_spare_servers="3"
     
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
