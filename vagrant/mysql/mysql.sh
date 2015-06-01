#!/bin/sh

sudo apt-get -y install mysql-server-5.5 mysql-server mysql-client php5-mysql

# Install MySQL
echo 'mysql-server mysql-server/root_password password root' | sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | sudo debconf-set-selections

# Create Database if it doesn't exist
if [ ! -d /var/lib/mysql/project ]; then
  mysqladmin -uroot -proot create project;
else
  printf "Project database already exists.\n"
fi
