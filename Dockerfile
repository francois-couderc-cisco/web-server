# Version: 0.0.5
FROM fcouderc/base-ubuntu:latest
MAINTAINER Francois Couderc "fcouderc@cisco.com"
RUN rm /var/www/html/index.html
COPY index.php /var/www/html
COPY run_processes.sh /sbin
EXPOSE 80
CMD ["/sbin/run_processes.sh"]
