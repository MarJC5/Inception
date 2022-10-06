FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@42lausanne.ch>"

# Install nginx
RUN apk update && apk upgrade \
    && apk add php7 php7-fpm php7-opcache \
    php7-gd php7-mysqli php7-zlib php7-curl \
    php7-mbstring php7-json php7-session

CMD ["php-fpm7", "-F"]