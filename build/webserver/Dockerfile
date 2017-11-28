FROM ubuntu:latest
MAINTAINER Phill S <cereal7802@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. curl and lynx-cur are for debugging the container.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ssh screen apache2 php libapache2-mod-php php-pear php-gd php-mysql php-curl php-json unrar lame mediainfo subversion ffmpeg 

# Enable apache mods.
RUN a2enmod rewrite

# Update the PHP.ini file
#RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini 
#RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini 
#RUN sed -i "s/max_execution_time.*$/max_execution_time = 120/" /etc/php/7.0/apache2/php.ini 
#RUN sed -i "s/memory_limit =.*/memory_limit = -1/" /etc/php/7.0/apache2/php.ini 

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND
