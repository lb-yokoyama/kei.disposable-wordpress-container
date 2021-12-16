FROM centos:7
COPY .wordpress/* /usr/tmpl/
RUN exec -a /sbin/init /usr/tmpl/wp_apache.sh \
	&& chown -R httpd:httpd /var/www/html
ENTRYPOINT /sbin/init apache2 --FOREGROUND
