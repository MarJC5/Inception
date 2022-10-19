#!/bin/bash

# Configure the php-fpm
target="/etc/php7/php-fpm.d/www.conf"

# Check if listen exists in the file
grep -E "listen = 127.0.0.1" $target >/dev/null 2>&1

# configure www.conf
if [ $? -eq 0 ]; then
  sed -i "s|.*listen = 127.0.0.1.*|listen = 0.0.0.0:9000|g" $target
fi

# Configure wordpress core installation
if [ ! -f "wp-config.php" ]; then

  # Install wordpress
  wp core download

  # Add php info file
  cp /conf/phpinfo.php /var/www/"$DOMAIN"

  # Wait until wp download is finished and then install
  while [ ! -f "wp-config-sample.php" ]; do
    sleep 1
  done

  # Configure wp-config.php
  wp core config \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST"

  # Wait until wp-config.php is created
  while [ ! -f "wp-config.php" ]; do
      sleep 1
  done

  # Create admin user
  wp core install \
    --url="https://$DOMAIN" \
    --title="$DOMAIN" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PWD" \
    --admin_email="$WP_ADMIN_EMAIL" --skip-email

  # Update plugins
  wp plugin update --all

  # Create normal user
  wp user create \
    "$WP_USER" \
    "$WP_USER_EMAIL" \
    --role=editor \
    --user_pass="$WP_USER_PWD"
fi

# Run php-fpm
php-fpm7 --nodaemonize
