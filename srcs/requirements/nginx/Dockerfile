FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@42lausanne.ch>"

WORKDIR /var/www/html/${DOMAIN}

# Install nginx
RUN apk update && apk upgrade && apk add nginx && apk add openssl

# Generate ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/${DOMAIN}.key \
    -out /etc/ssl/certs/${DOMAIN}.crt \
    -subj "/C=CH/ST=Geneva/L=Geneva/O=42/OU=42/CN=${DOMAIN}"

# Copy nginx configuration
COPY ./srcs/requirements/nginx/nginx.conf /etc/nginx/nginx.conf

# Copy test.php
COPY ./srcs/requirements/nginx/config/test.php /var/www/html/${DOMAIN}/test.php

# Start nginx
CMD ["nginx", "-g", "daemon off;"]