FROM ubuntu:latest
MAINTAINER Phill S <cereal7802@gmail.com>

RUN apt-get update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ssh wget screen apache2 php libapache2-mod-php php-pear php-gd php-mysql php-mbstring php-curl php-json unrar lame mediainfo subversion ffmpeg supervisor

# Install yenc for php
RUN wget https://github.com/niel/php-yenc/releases/download/v1.3.0/php7.0-yenc_1.3.0_amd64.deb && dpkg -i php7.0-yenc_1.3.0_amd64.deb && rm php7.0-yenc_1.3.0_amd64.deb

# Enable apache mods.
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV path /:/var/www/newznab/www/
ENV SNVUSER settosvnuser
ENV SVNPASS settosvnpass

RUN service apache2 restart

#add newznab processing script
ADD ./newznab.sh /newznab.sh
RUN chmod 755 /*.sh

#Setup supervisor to start Apache and the Newznab scripts to load headers and build releases
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
COPY newznab.sh.conf /etc/supervisor/conf.d/newznab.sh.conf

VOLUME /var/www/newznab
EXPOSE 80
WORKDIR /var/www/newznab/

#kickoff Supervisor to start the functions
CMD ["/usr/bin/supervisord"]
