FROM ubuntu:20.04

RUN apt -y update
RUN apt -y install nginx
RUN apt -y install php


COPY ./index.php /var/www/html/index.php



CMD ["/usr/sbin/nginx","-D","FOREGROUND"]

EXPOSE 80
