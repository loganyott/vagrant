#!/bin/sh

sudo apt-get -y install php5-fpm php5-gd php5-imagick php5-mcrypt php-apc php5-imap php5-curl php-pear php5-xdebug

# Copy config files into place
sudo cp /var/vagrant/php-fpm/php.ini /etc/php5/fpm/php.ini
sudo cp /var/vagrant/php-fpm/pool_www.conf /etc/php5/fpm/pool.d/www.conf

# Restart PHP
sudo service php5-fpm restart
