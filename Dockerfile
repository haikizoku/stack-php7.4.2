FROM php:7.4-fpm

LABEL Author = "Norvene Gregory"
LABEL Description = "Dockerfile pour héberger mon  application"

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils locales apt-utils git

#Install some base extensions
RUN apt-get install -y \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev  \
        zip \
  && docker-php-ext-install \
        zip \
        intl \
        mysqli \
        pdo pdo_mysql

RUN apt-get update && apt-get install -y vim

#Install local
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Copy  application
COPY ./app/  /var/www/app

WORKDIR /var/www/app/
