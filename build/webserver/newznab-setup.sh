#!/bin/bash

if [[ -z "$SVNUSER" || -z "$SVNPASS" ]]; then
  echo "$(date) - Please set the SVNUSER and the SVNPASS environment vars for the container." >> /var/log/newznab/setup.log
  exit 1
fi

if [ -f /var/www/newznab/notouch ]; then
  echo "$(date) - notouch file was found. newznab-setup.sh exited." >> /var/log/newznab/setup.log
  exit
fi

chown -R ${APACHE_RUN_USER}:${APACHE_RUN_USER} /var/www/newznab

/usr/bin/svn co --username "$SVNUSER" --password "$SVNPASS" --non-interactive svn://svn.newznab.com/nn/branches/nnplus /var/www/newznab/

cat > /var/www/newznab/www/config.php << EOF
<?php

//========================
// Config you must change
//========================
define('DB_TYPE', 'mysql');
define('DB_HOST', 'database');
define('DB_PORT', 3306);
define('DB_USER', 'root');
define('DB_PASSWORD','newznab');
define('DB_NAME', 'newznab');
define('DB_INNODB', false);
define('DB_PCONNECT', true);
define('DB_ERRORMODE', PDO::ERRMODE_SILENT);

define('NNTP_USERNAME', 'xxxxxxx');
define('NNTP_PASSWORD', 'xxxxxxx');
define('NNTP_SERVER', 'reader.usenetbucket.com');
define('NNTP_PORT', '443');
define('NNTP_SSLENABLED', true);

define('CACHEOPT_METHOD', 'memcache');
define('CACHEOPT_TTLFAST', '120');
define('CACHEOPT_TTLMEDIUM', '600');
define('CACHEOPT_TTLSLOW', '1800');
define('CACHEOPT_MEMCACHE_SERVER', 'memcached');
define('CACHEOPT_MEMCACHE_PORT', '11211');

// define('EXTERNAL_PROXY_IP', ''); //Internal address of public facing server
// define('EXTERNAL_HOST_NAME', ''); //The external hostname that should be used

require("automated.config.php");
EOF

chown -R ${APACHE_RUN_USER}:${APACHE_RUN_USER} /var/www/newznab

chmod -R 777 /var/www/newznab/www/lib/smarty/templates_c
chmod -R 777 /var/www/newznab/www/covers
chmod -R 777 /var/www/newznab/www/install
chmod -R 777 /var/www/newznab/nzbfiles



touch /var/www/newznab/notouch
