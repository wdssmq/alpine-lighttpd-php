FROM alastairhm/alpine-lighttpd:3.14

RUN apk --update add \
    php-common \
    php-iconv \
    php-json \
    php-gd \
    php-curl \
    php-xml \
    php-simplexml \
    php-pgsql \
    php-imap \
    php-cgi \
    fcgi \
    php-pdo \
    php-pdo_pgsql \
    php-mysqli \
    php-soap \
    php-xmlrpc \
    php-posix \
    php-gettext \
    php-ldap \
    php-ctype \
    php-dom && \
    rm -rf /var/cache/apk/*

ADD etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD etc/php7/php.ini /etc/php7/php.ini
RUN mkdir -p /run/lighttpd/
RUN chown www-data. /run/lighttpd/

EXPOSE 80
VOLUME /var/www

CMD php-fpm -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf

