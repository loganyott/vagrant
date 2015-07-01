#!/bin/sh

sudo apt-get -y install mysql-client php5-mysql

# Install MySQL
echo 'mysql-server mysql-server/root_password password root' | sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | sudo debconf-set-selections
sudo apt-get -y install mysql-server

# Create Database if it doesn't exist
if [ ! -d /var/lib/mysql/$MYSQL_NAME ]; then
  mysqladmin -u$MYSQL_USER -p$MYSQL_PASS create $MYSQL_NAME;
else
  printf "$MYSQL_NAME database already exists.\n"
fi
