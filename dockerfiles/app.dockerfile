FROM php:8.2-fpm-alpine
WORKDIR /var/www/html
COPY src .

# Dependencias del sistema (incluye herramientas que Composer necesita)
RUN apk add --no-cache \
    curl git unzip \
    mysql-client msmtp perl wget procps shadow \
    libzip libpng libjpeg-turbo libwebp icu-libs freetype

# Herramientas de compilación y dev headers temporalmente
RUN apk add --no-cache --virtual build-essentials \
    icu-dev zlib-dev g++ make automake autoconf libzip-dev \
    libpng-dev libwebp-dev libjpeg-turbo-dev freetype-dev && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install gd mysqli pdo_mysql intl bcmath opcache exif zip && \
    apk del build-essentials && rm -rf /usr/src/php*

# Instalar Composer (binario global)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar Node.js y npm
RUN apk add --no-cache nodejs npm

# Crear usuario no root
RUN addgroup -g 1000 userOne && adduser -G userOne -g userOne -s /bin/sh -D userOne

# Asegurar permisos de trabajo
RUN chown -R userOne:userOne /var/www/html

# ===== Clave: hacer disponible 'laravel' al usuario =====
# Añadir los vendor/bin globales al PATH de la imagen (root y user)
ENV PATH="/home/userOne/.composer/vendor/bin:/root/.composer/vendor/bin:${PATH}"

# Instalar Laravel Installer globalmente para userOne
USER userOne
RUN mkdir -p /home/userOne/.composer && \
    composer global require laravel/installer

USER userOne
