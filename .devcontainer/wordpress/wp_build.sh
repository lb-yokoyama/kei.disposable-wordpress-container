#!bin/bash
mv /usr/tmpl/nginx.repo /etc/yum.repos.d/nginx.repo
echo "hi, this is wp_build v0.1.2"
exec /sbin/init &
yum update -y
yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y --enablerepo=remi-php74 php-fpm php-mbstring php-pdo php-gd php-mysqlnd nginx yum-cron git vsftpd
systemctl enable nginx
systemctl enable php-fpm
systemctl enable yum-cron
systemctl enable vsftpd
echo "NGINX php-fpm starts"
nginx && php-fpm -D
echo "NGINX started, it worked."
mv -f /usr/tmpl/wp.conf /etc/nginx/conf.d/default.conf
sed 's/apply updates = no/apply updates = yes/' /etc/yum/yum-cron.conf>/etc/yum/yum-cron.conf
mv -f /usr/tmpl/php.www.conf /etc/php-fpm.d/www.conf
