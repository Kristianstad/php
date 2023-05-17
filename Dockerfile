# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_REPO=${SaM_REPO:-ghcr.io/kristianstad/secure_and_minimal}
ARG ALPINE_VERSION=${ALPINE_VERSION:-3.18}
ARG PHP_VERSION="82"
ARG IMAGETYPE="application,base"
ARG MAKEDIRS="/etc/php$PHP_VERSION/conf.d /etc/php$PHP_VERSION/php-fpm.d"
ARG RUNDEPS="\
#        php$PHP_VERSION \
#        php$PHP_VERSION-bcmath \
        php$PHP_VERSION-dom \
#        php$PHP_VERSION-ctype \
        php$PHP_VERSION-curl \
#        php$PHP_VERSION-fileinfo \
        php$PHP_VERSION-fpm \
#        php$PHP_VERSION-gd \
#        php$PHP_VERSION-iconv \
        php$PHP_VERSION-intl \
        php$PHP_VERSION-json \
        php$PHP_VERSION-mbstring \
#        php$PHP_VERSION-mcrypt \
#        php$PHP_VERSION-mysqlnd \
        php$PHP_VERSION-opcache \
        php$PHP_VERSION-openssl \
#        php$PHP_VERSION-pdo \
#        php$PHP_VERSION-pdo_mysql \
#        php$PHP_VERSION-pdo_pgsql \
#        php$PHP_VERSION-pdo_sqlite \
#        php$PHP_VERSION-phar \
#        php$PHP_VERSION-posix \
        php$PHP_VERSION-simplexml \
        php$PHP_VERSION-session \
#        php$PHP_VERSION-soap \
#        php$PHP_VERSION-tokenizer \
#        php$PHP_VERSION-xml \
#        php$PHP_VERSION-xmlreader \
#        php$PHP_VERSION-xmlwriter \
#        php$PHP_VERSION-zip \
        php$PHP_VERSION-pgsql \
        php$PHP_VERSION-pecl-imagick \
#        libpng \
#        libpng-static \
#        libpng-utils \
#        libjpeg-turbo \
#        imagemagick \
#        curl \
        php$PHP_VERSION-pecl-apcu \
        php$PHP_VERSION-ldap"
#        composer"
ARG STARTUPEXECUTABLES="/usr/sbin/php-fpm$PHP_VERSION"
ARG REMOVEFILES="/etc/php$PHP_VERSION/php-fpm.d/www.conf"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${BASEIMAGE:-$SaM_REPO:base-$ALPINE_VERSION} as base
FROM ${INITIMAGE:-scratch} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-$SaM_REPO:build-$ALPINE_VERSION} as build
FROM ${BASEIMAGE:-$SaM_REPO:base-$ALPINE_VERSION} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_LINUX_USER="php" \
    VAR_FINAL_COMMAND="php-fpm$PHP_VERSION --nodaemonize --force-stderr" \
    VAR_SOCKET_FILE="/run/php$PHP_VERSION-fpm/socket" \
    VAR_LOG_FILE="/var/log/php$PHP_VERSION/error.log" \
    VAR_wwwconf_listen='$VAR_SOCKET_FILE' \
    VAR_wwwconf_pm="dynamic" \
    VAR_wwwconf_pm__max_children="5" \
    VAR_wwwconf_pm__min_spare_servers="1" \
    VAR_wwwconf_pm__max_spare_servers="3"
     
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
