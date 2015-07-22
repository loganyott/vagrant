#!/bin/sh

sudo apt-get install -y nginx

# Configure Nginx
sudo rm /etc/nginx/sites-enabled/*
sudo cp /var/vagrant/nginx/localhost.conf /etc/nginx/sites-enabled/localhost.conf
sed -i "s:root .*$:root $DOCROOT;:" /etc/nginx/sites-enabled/localhost.conf
sudo cp /var/vagrant/nginx/nginx.conf /etc/nginx/nginx.conf

# Restart Nginx
sudo service nginx reload
