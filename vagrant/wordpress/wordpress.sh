# WordPress Config
# Install WP-CLI
if [ ! -f /usr/local/bin/wp ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp
else
  printf "WP_CLI already installed.\n"
fi 

if [ ! -f /etc/bash_completion.d/wp-cli ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash
  mv wp-completion.bash /etc/bash_completion.d/wp-cli
fi

# Copy wp-config into place
if [ ! -f /srv/vagrant/wp-config.php ]; then
  sudo cp /var/vagrant/wordpress/wp-config.php /srv/www/wp-config.php
else
  printf "wp-config.php already exists.\n"
fi

