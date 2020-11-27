#!/bin/bash
if [ -d "/var/www/html/install]"; then
  echo "Simulating Gestsup database install configuration with docker settings"
  cd /var/www/html/install
  if export QUERY_STRING="step=2&server=$MYSQL_HOST&port=3306&dbname=$MYSQL_DATABASE&user=$MYSQL_USER&password=$MYSQL_PASSWORD"
  \
  php -e -r 'parse_str($_SERVER["QUERY_STRING"], $_POST); include "index.php";'; then
  echo "Install successfull"
  cd ..
  rm -rf install
  echo "Deleted install directory"
  else
    echo "Install failed"
  fi
fi

exec "apache2-foreground"
