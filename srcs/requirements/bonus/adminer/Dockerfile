FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@student.42lausanne.ch>"

# Install php dependencies for adminer
RUN apk update && apk upgrade \
    && apk add --no-cache --quiet --update \
 		   php7-common php7-iconv php7-json php7-gd php7-curl php7-xml \
           php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc \
           php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7 php7-fpm php7-opcache php7-session \
           curl

# Set the working directory
WORKDIR /var/www/html

# Install adminer
RUN curl --request GET -sL \
    --url 'http://www.adminer.org/latest.php'\
    --output 'index.php'
RUN chmod 755 index.php

# Install theme
RUN curl --request GET -sL \
	--url 'https://raw.githubusercontent.com/pepa-linha/Adminer-Design-Dark/master/adminer.css'\
	--output 'adminer.css'

# Start adminer server
# login with => $DB_USER:$DB_PASSWORD:$DB_NAME:$DB_HOST
CMD php -S 0.0.0.0:8080
