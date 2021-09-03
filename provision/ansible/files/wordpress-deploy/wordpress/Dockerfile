FROM wordpress:4.8-apache

VOLUME /var/www/html

COPY plugins /tmp/plugins
COPY copy-plugins.sh /tmp/copy-plugins.sh

ENTRYPOINT ["/tmp/copy-plugins.sh"]

CMD ["apache2-foreground"]
