#!/bin/sh

# Upgrade existing packages
sudo apt-get -y update

sudo apt-get -y install git vim nodejs

if [ ! -f /etc/profile.d/vagrant.sh ]; then
	touch /etc/profile.d/vagrant.sh
fi
echo 'cd /srv/www' > /etc/profile.d/vagrant.sh

if [ ! -f /etc/vim/vimrc.local ]; then
	cp /var/vagrant/vimrc.local /etc/vim/vimrc.local
fi
