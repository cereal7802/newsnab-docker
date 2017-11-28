FROM ubuntu:latest
MAINTAINER Phill S <cereal7802@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ssh screen apache2 php libapache2-mod-php php-pear php-gd php-mysql php-curl php-json unrar lame mediainfo subversion ffmpeg 

# Enable apache mods.
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND
