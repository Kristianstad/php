# Secure and Minimal image of Php.
# https://hub.docker.com/repository/docker/huggla/sam-php

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.4"
ARG IMAGETYPE="application,base"
ARG MAKEDIRS="/etc/php7/conf.d /etc/php7/php-fpm.d"
ARG RUNDEPS="\
#        php7 \
#        php7-bcmath \
#        php7-dom \
#        php7-ctype \
        php7-curl \
#        php7-fileinfo \
        php7-fpm \
#        php7-gd \
#        php7-iconv \
#        php7-intl \
        php7-json \
#        php7-mbstring \
        php7-mcrypt \
#        php7-mysqlnd \
        php7-opcache \
#        php7-openssl \
#        php7-pdo \
#        php7-pdo_mysql \
#        php7-pdo_pgsql \
#        php7-pdo_sqlite \
#        php7-phar \
#        php7-posix \
#        php7-simplexml \
        php7-session \
#        php7-soap \
#        php7-tokenizer \
#        php7-xml \
#        php7-xmlreader \
#        php7-xmlwriter \
#        php7-zip \
        php7-pgsql \
        php7-pecl-imagick \
#        libpng \
#        libpng-static \
#        libpng-utils \
#        libjpeg-turbo \
#        imagemagick \
#        curl \
        php7-pecl-apcu \
        php7-ldap"
#        composer"
ARG STARTUPEXECUTABLES="/usr/sbin/php-fpm7"
ARG REMOVEFILES="/etc/php7/php-fpm.d/www.conf"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base}} as init
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
    VAR_FINAL_COMMAND="php-fpm7 --nodaemonize --force-stderr" \
    VAR_SOCKET_FILE="/run/php7-fpm/socket" \
    VAR_LOG_FILE="/var/log/php7/error.log" \
    VAR_wwwconf_listen='$VAR_SOCKET_FILE' \
    VAR_wwwconf_pm="dynamic" \
    VAR_wwwconf_pm__max_children="5" \
    VAR_wwwconf_pm__min_spare_servers="1" \
    VAR_wwwconf_pm__max_spare_servers="3"
     
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
