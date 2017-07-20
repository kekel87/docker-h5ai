FROM alpine:3.5
LABEL Maintainer="kekel87 <https://github.com/kekel87>" \
      Description="Lightweight container with Nginx 1.10 & PHP-FPM 7.1 based on Alpine Linux."

# ARG allow it to be overridden at build time
ARG IMAGICK_EXT_VERSION=3.4.2
ARG H5AI_VERSION=0.29.0

ENV HTTPD_USER www-data

COPY class-setup.php.patch class-setup.php.patch

# Install packages from testing repo's
RUN apk add --no-cache --virtual .build-deps \
    unzip \
    openssl \
    ca-certificates \
    wget \
    patch \
 && apk --no-cache add \
    nginx \
    php7-mbstring \
    php7-fpm \
    php7-exif \
    php7-gd \
    php7-json \
    php7-zip \
    php7-session \
    supervisor  \
    zip \
    acl \
    ffmpeg \
    imagemagick \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \

 # Install packages from stable repo's
 && apk --no-cache add supervisor curl \

 # Install h5ai
 && wget --no-check-certificate  https://release.larsjung.de/h5ai/h5ai-${H5AI_VERSION}.zip -P /tmp \
 && unzip /tmp/h5ai-${H5AI_VERSION}.zip -d /usr/share/h5ai \

# patch h5ai because we want to deploy it ouside of the document root and use /var/www as root for browsing

 && patch -p1 -u -d /usr/share/h5ai/_h5ai/private/php/core/ -i /class-setup.php.patch \
 
 # Clean php7-pear php7-dev
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* /tmp/* /class-setup.php.patch

# Configure H5AI
COPY config/h5ai.options.json /usr/share/h5ai/_h5ai/private/conf/options.json

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# make the cache writable
RUN chmod -R 777 /usr/share/h5ai/_h5ai/public/cache/
RUN chmod -R 777 /usr/share/h5ai/_h5ai/private/cache/

# use supervisor to monitor all services
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# expose path
WORKDIR /var/www