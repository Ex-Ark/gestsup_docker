FROM debian:10

ENV PHP_VERSION 7.3
ENV GESTSUP_VERSION 3.2.0

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get install wget apache2 php$PHP_VERSION php$PHP_VERSION-mysql php$PHP_VERSION-xml php$PHP_VERSION-curl php$PHP_VERSION-imap php$PHP_VERSION-ldap php$PHP_VERSION-zip php$PHP_VERSION-mbstring php$PHP_VERSION-gd unzip ntp -y
RUN mkdir -p /var/www/html
RUN wget -P /var/www/html https://gestsup.fr/downloads/versions/current/stable/gestsup_$GESTSUP_VERSION.zip
RUN unzip /var/www/html/gestsup_$GESTSUP_VERSION.zip -d /var/www/html

RUN rm /var/www/html/gestsup_$GESTSUP_VERSION.zip
RUN rm /var/www/html/index.html

#COPY connect.php /var/www/html

RUN adduser gestsup --ingroup www-data
RUN chown -R gestsup:www-data /var/www/html
RUN find /var/www/html/ -type d -exec chmod 750 {} \;
RUN find /var/www/html/ -type f -exec chmod 640 {} \;

RUN chmod 770 -R /var/www/html/upload
RUN chmod 770 -R /var/www/html/images/model
RUN chmod 770 -R /var/www/html/log
RUN chmod 770 -R /var/www/html/backup
RUN chmod 770 -R /var/www/html/_SQL
RUN chmod 660 /var/www/html/connect.php

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
