FROM ubuntu:20.04

RUN apt -y update
RUN apt -y install nginx

COPY ./index.html /var/www/html/index.html



CMD ["/usr/sbin/nginx","-D","FOREGROUND"]

EXPOSE 80
