#!/bin/sh

if [ ! -f /usr/local/bin/composer ]; then
  curl -sS https://getcomposer.org/installer | php
  chmod +x composer.phar
  mv composer.phar /usr/local/bin/composer
fi

echo "export PATH=/srv/www/vendor/bin/:$HOME/.composer/vendor/bin:$PATH" >> /etc/profile.d/vagrant.sh
