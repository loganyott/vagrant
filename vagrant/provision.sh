#!/bin/sh

# Upgrade existing packages
sudo apt-get -y update

# Install a bunch of crap
sudo apt-get -y install git mysql-client nginx php5-fpm php5-gd php5-imagick php5-mcrypt php5-mysql php-apc php5-imap php5-curl php5-sybase vim php-pear php5-xdebug nodejs

# Install MySQL
echo 'mysql-server mysql-server/root_password password root' | sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | sudo debconf-set-selections
sudo apt-get -y install mysql-server

# Copy config files into place
sudo cp /srv/www/vagrant/php.ini /etc/php5/fpm/php.ini
sudo cp /srv/www/vagrant/pool_www.conf /etc/php5/fpm/pool.d/www.conf

# Configure Nginx
sudo rm /etc/nginx/sites-enabled/*
sudo cp /srv/www/vagrant/localhost.conf /etc/nginx/sites-enabled/localhost.conf
sudo cp /srv/www/vagrant/nginx.conf /etc/nginx/nginx.conf

# Create a database
mysqladmin -uroot -proot create project;

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Restart PHP
sudo service php5-fpm restart

# Restart Nginx
sudo service nginx restart
