
FROM php:7.4-apache
LABEL Author = "Norvene Gregory"
LABEL Description = "Dockerfile pour héberger mon  application"

RUN apt-get update
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql

#=====================
# Updates for debconf
# Prevent message 'debconf: unable to initialize frontend: Dialog'
# Prevent message 'debconf: delaying package configuration, since apt-utils is not installed'
#=====================

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y --no-install-recommends apt-utils locales apt-utils git

#Install some base extensions
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip

RUN apt-get update && apt-get install -y vim

#Install local
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Copy apache conf
COPY ./config-docker/apache/apache.conf /etc/apache2/sites-available/000-default.conf

#Copy  application
COPY ./app  /var/www/app

WORKDIR /var/www/app/
