FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@student.42lausanne.ch>"

ARG DOMAIN
ARG DIR=/var/www/${DOMAIN}

# Install nginx
RUN apk update && apk upgrade \
    && apk add --no-cache --quiet --update \
    	   php7 php-phar php-json php-curl php-fpm php-mysqli php-iconv \
    	   vim curl bash mariadb-client

# Set up wp directory
WORKDIR ${DIR}

# Add wp-cli && give runnig permissions
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    --output /usr/bin/wp
RUN chmod +x /usr/bin/wp

# Copy phpconf.ini
COPY conf/php.conf.ini /usr/local/etc/php/conf.d/conf.ini

# Copy phpinfo.php
COPY conf/phpinfo.php /conf/phpinfo.php

# Copy entrypoint.sh script
COPY ./scripts/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Start php-fpm
ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
