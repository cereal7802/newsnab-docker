FROM ubuntu:latest
MAINTAINER Phill S <cereal7802@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ssh screen apache2 php libapache2-mod-php php-pear php-gd php-mysql php-mbstring php-curl php-json unrar lame mediainfo subversion ffmpeg supervisor

# Enable apache mods.
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV nn_user user
ENV nn_pass password
ENV path /:/var/www/newznab/www/

# add the Config to Apache
RUN mkdir /var/www/newznab/

# pull NNab plus from SVN - Note you need the username and password for Svn Above
RUN svn co --username $nn_user --password $nn_pass svn://svn.newznab.com/nn/branches/nnplus /var/www/newznab/
RUN chmod 777 /var/www/newznab/www/lib/smarty/templates_c && \
chmod 777 /var/www/newznab/www/covers/movies && \
chmod 777 /var/www/newznab/www/covers/anime  && \
chmod 777 /var/www/newznab/www/covers/music  && \
chmod 777 /var/www/newznab/www  && \
chmod 777 /var/www/newznab/www/install  && \
chmod 777 /var/www/newznab/nzbfiles/

RUN service apache2 restart

# add newznab config file - This needs to be edited
ADD ./config.php /var/www/newznab/www/config.php
RUN chmod 777 /var/www/newznab/www/config.php

#add newznab processing script
ADD ./newznab.sh /newznab.sh
RUN chmod 755 /*.sh

#Setup supervisor to start Apache and the Newznab scripts to load headers and build releases

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
WORKDIR /var/www/newznab/www/

#kickoff Supervisor to start the functions
CMD ["/usr/bin/supervisord"]
