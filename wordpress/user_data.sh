#!/bin/bash
#setting up the LAMP stack for wordpress and installing the wordpress
apt update -y
apt install apache2 -y
apt install mysql-server mysql-client -y
apt install wget -y
apt install php php-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl} -y
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mv wordpress/* /var/www/html
rm /var/www/html/index.html
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
#creating database and user in mysql
WP_DATABASE="wordpress_db"
WP_USER="prince"
WP_HOST="localhost"
WP_PASSWORD="1"
WP_CONFIG="/var/www/html/wp-config.php"
MYSQL_USER="root"
MYSQL_PASSWORD="2"
mysql -e "create database $WP_DATABASE;"
mysql -e "create user '$WP_USER@$WP_HOST' identified by '1';"
mysql -e "grant all privileges on $WP_DATABASE.* to $WP_USER@$WP_HOST;"
mysql -e "flush privileges;"
#edit the wp-config.php file and fill the detail of database in that using sed command
sed -i 's/database_name_here/$WP_DATBASE/' $WP_CONFIG
sed -i 's/username_here/$WP_USER/' $WP_CONFIG
sed -i 's/password_here/$WP_PASSWORD/' $WP_CONFIG
#change the ownership of the dir from root to www-data
chown www-data:www-data /var/www/html

echo "hogeya kam!!"
