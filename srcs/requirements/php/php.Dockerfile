FROM php-fpm:7.4.3-fpm-alpine3.11

RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*