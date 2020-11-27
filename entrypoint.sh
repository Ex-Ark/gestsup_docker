#!/bin/bash
echo "Waiting for mariadb to accept connections..."
while ! mysqladmin ping -h "$MYSQL_HOST" --silent; do
  sleep 1
done
if [ -d "/var/www/html/install" ]; then
  echo "Simulating Gestsup database installation with docker settings"
  cd /var/www/html/install
  echo "Generating connect.php file with docker values"
  if QUERY_STRING="step=1&server=$MYSQL_HOST&port=3306&dbname=$MYSQL_DATABASE&user=$MYSQL_USER&password=$MYSQL_PASSWORD" php -e -r 'parse_str($_SERVER["QUERY_STRING"], $_POST); include "index.php";' >/dev/null; then
    echo "Connect.php file generated successfully"
    echo "Creating database & tables"
    if QUERY_STRING="step=2&server=$MYSQL_HOST&port=3306&dbname=$MYSQL_DATABASE&user=$MYSQL_USER&password=$MYSQL_PASSWORD" php -e -r 'parse_str($_SERVER["QUERY_STRING"], $_POST); include "index.php";' >/dev/null; then
      echo "Gestsup database created successfull"
      cd ..
      rm -rf install
      echo "Deleted /var/www/html/install/ directory"
    else
      echo "Error: Gestsup database could not be created"
    fi
  else
    echo "Error: Connect.php could not be created"
  fi
else
  echo "Install skipped"
fi

exec apachectl -D "FOREGROUND"
