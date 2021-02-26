#!/bin/sh

set -e

cp -r /tmp/plugins/* /var/www/html/wp-content/plugins/
chown -R www-data:www-data /var/www/html

exec "$@"
