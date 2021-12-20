FROM centos:7
COPY ./wordpress/* /usr/tmpl/
# ADD https://ja.wordpress.org/wordpress-5.2.13-ja.tar.gz /var/www/html
RUN exec /usr/sbin/init & \
  mkdir -p /var/www/html \
  && yum remove -y php httpd; yum clean all; \
  yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
  && yum update -y \
  && yum install -y yum install --enablerepo=remi,remi-php80 php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt php-mysqlnd \
    httpd-2.4.6-97.el7.centos.x86_64 git gzip zip curl \
  && systemctl enable httpd.service\
  && mv -f /usr/tmpl/wp-config.php /var/www/html/wp-config.php \
  && chown -R daemon:daemon /var/www/html \
  && chmod -R 770 /var/www/html \
  && echo 'NameVirtualHost *:80' >> /etc/httpd/conf/httpd.conf \
  && mv /usr/tmpl/apache.conf /etc/httpd/conf.d/wp.conf \
  && rm -fr /usr/tmpl
  # && echo 'alias php=php81'>> ~/.bashrc \
  # && curl 'https://ja.wordpress.org/wordpress-5.2.13-ja.tar.gz' -o '/var/www/html/wp5_2_13jp.tar.gz' | tee /var/www/html/debug-cmd.log \
  # && gunzip /var/www/html/wp5_2_13jp.tar.gz | tee /var/www/html/debug-cmd.log \
  # && echo 'ServerName localhost:80'>>/etc/httpd/conf/httpd.conf \
  # && sed 's/#NameVirtualHost *:80/NameVirtualHost *:80/' /etc/httpd/conf/httpd.conf>/etc/httpd/conf/httpd.conf \
ENTRYPOINT /usr/sbin/init & httpd
