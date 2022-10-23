FROM alpine:3.14

LABEL maintainer="Martin Jean-Christio <jmartin@student.42lausanne.ch>"

RUN apk update && apk upgrade \
    && apk add --no-cache --quiet --update \
    mariadb-client vim

# Set the working directory
WORKDIR /backup

# Copy the backup script
COPY ./scripts/backup.sh /tmp/backup.sh
RUN chmod +x /tmp/backup.sh

ENTRYPOINT ["sh", "/tmp/backup.sh"]
