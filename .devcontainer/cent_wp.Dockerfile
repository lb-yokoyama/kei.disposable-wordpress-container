FROM centos:7
COPY .wordpress/* /usr/tmpl/
RUN exec -a /sbin/init /usr/tmpl/wp_build.sh \
	&& chown -R nginx:nginx /var/www/data
ENTRYPOINT /sbin/init php-fpm
