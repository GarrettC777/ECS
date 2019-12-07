# Docker

This is where the Dockerfile that determines what is installed in our servers is located.

The Docker instructions go as is:

FROM ubuntu:latest
MAINTAINER Artur Tarverdyan

-RUN apt-get update -y

-RUN apt-get upgrade -y

-RUN apt-get install -y nano git curl zip

-RUN apt-get install -y apache2

-RUN apache2 -v

RUN service apache2 start

RUN apt-get install -y mysql-client

RUN dpkg --get-selections | grep mysql

ENV DEBIAN_FRONTEND noninteractive

ENV DEDCONF_NONINTERACTIVE_SEEN true

RUN apt-get install -y php libapache2-mod-php php-mysql php7.2-cli php7.2-curl php7.2-gd php7.2-mbstring php7.2-mysql php7.2-xml

RUN rm /etc/apache2/mods-enabled/dir.conf

COPY dir.conf /etc/apache2/mods-enabled/

RUN git clone https://github.com/csuntechlab/affinity.git /var/www/html/affinity

RUN su chown -hR www-data:www-data /var/www/html/affinity/

RUN ln -s /var/www/html/affinity/public /var/www/html/public

RUN rm /etc/apache2/apache2.conf

COPY apache2.conf /etc/apache2/

RUN rm /etc/apache2/sites-available/000-default.conf

COPY 000-default.conf /etc/apache2/sites-available/

RUN service apache2 restart

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN composer install /var/www/html/affinity

EXPOSE 80


