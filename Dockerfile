FROM nginx:alpine

LABEL authors="github.com/davidsuart"

# Install our nginx/php packages
#
RUN \
  apk add --no-cache \
  openrc \
  nginx \
  php7-common \
  php7-cgi \
  php7-fpm \
  fcgi

# nginx config
#
RUN mkdir -p "/etc/nginx/conf.d" && chmod -R 755 "/etc/nginx/conf.d"
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
RUN chown -R nginx:nginx "/etc/nginx/conf.d"
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# php config
#
RUN mkdir -p "/etc/php7/php-fpm.d" && chmod -R 755 "/etc/php7/php-fpm.d"
COPY php/www.conf /etc/php7/php-fpm.d/www.conf
# COPY php/php.ini /etc/php7/php.ini
RUN chown -R nginx:nginx "/etc/php7"

# www content
#
RUN mkdir -p "/usr/share/nginx/html" && chmod -R 755 "/usr/share/nginx/html"
COPY nginx/index.php /usr/share/nginx/html/index.php
RUN chown -R nginx:nginx "/usr/share/nginx/html"

# expose http
#
EXPOSE 80

# Install supervisor to run nginx and php-fpm and heathcheck them
#
RUN \
  apk add --no-cache \
  curl \
  supervisor

COPY supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/ping
