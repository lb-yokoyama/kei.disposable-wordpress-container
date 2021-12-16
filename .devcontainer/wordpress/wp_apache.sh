#!bin/bash
echo "hi, this is wp_apache v0.0.1"
exec /sbin/init &
yum update -y \
  && yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
  && yum install -y --enablerepo=remi-php70 \
       php-fpm php-mbstring php-pdo php-gd php-mysqlnd \
       apache yum-cron git vsftpd
systemctl enable apache && systemctl enable yum-cron && systemctl enable vsftpd
echo "apache2 starts" \
  && apache2 -D \
  && echo "apache2 started, it worked."
sed 's/apply updates = no/apply updates = yes/' /etc/yum/yum-cron.conf>/etc/yum/yum-cron.conf
