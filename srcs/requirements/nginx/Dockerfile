FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@student.42lausanne.ch>"

ARG DOMAIN

# Install nginx
RUN apk update && apk upgrade \
    && apk add --no-cache --quiet --update \
    	   nginx openssl vim

# Generate ssl certificate
RUN	mkdir -p /etc/nginx/ssl/private /etc/nginx/ssl/certs

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/private/$DOMAIN.key \
    -out /etc/nginx/ssl/certs/$DOMAIN.crt \
    -subj "/C=CH/ST=Geneva/L=Geneva/O=42/OU=42/CN=$DOMAIN"

# Folder for the server configuration files
RUN mkdir -p /var/run/nginx

# Copy nginx configuration
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# Expose port 443
EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]