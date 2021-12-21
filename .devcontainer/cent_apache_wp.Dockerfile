FROM centos:7
COPY ./wordpress/* /usr/tmpl/
# ADD https://ja.wordpress.org/wordpress-5.2.13-ja.tar.gz /var/www/html
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
  systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*;\
  rm -f /etc/systemd/system/*.wants/*;\
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*;\
  rm -f /lib/systemd/system/anaconda.target.wants/*; \
  mkdir -p /var/www/html;
RUN /usr/sbin/init & \
  yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm; \
  yum update -y \
  && yum install -y --enablerepo=remi,remi-php70 \
  php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-mysqlnd \
  httpd-2.4.6-97.el7.centos.x86_64 git gzip zip curl; \
  systemctl enable httpd.service\
  && mv -f /usr/tmpl/wp-config.php /var/www/html/wp-config.php \
  && chown -R apache:apache /var/www/html \
  && chmod -R 770 /var/www/html \
  && echo 'ServerName localhost:80'>>/etc/httpd/conf/httpd.conf \
  && echo 'NameVirtualHost *:80' >> /etc/httpd/conf/httpd.conf \
  && mv /usr/tmpl/apache.conf /etc/httpd/conf.d/wp.conf \
  && rm -fr /usr/tmpl
# && echo 'alias php=php81'>> ~/.bashrc \
# && sed 's/#NameVirtualHost *:80/NameVirtualHost *:80/' /etc/httpd/conf/httpd.conf>/etc/httpd/conf/httpd.conf \
CMD ["/usr/sbin/init"]
ENTRYPOINT ["httpd", "-k", "start"]
