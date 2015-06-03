# WordPress Config
# Install WP-CLI
printf "Checking for Wp-CLI...\n"
if [ ! -f /usr/local/bin/wp ]; then
  printf "WP_CLI not found. Installing...\n"
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp
else
  printf "WP_CLI already installed.\n"
fi 

printf "Checking for WP-CLI autocompletion...\n"
if [ ! -f /etc/bash_completion.d/wp-cli ]; then
  printf "WP-CLI autocompletion not found. Installing...\n"
  curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash
  mv wp-completion.bash /etc/bash_completion.d/wp-cli
else
  printf "WP-CLI autcompletion already installed.\n"
fi

# Copy wp-config into place
printf "Checking for wp-config.php...\n"
if [ ! -f /srv/vagrant/wp-config.php ]; then
  printf "wp-config.php not found. Copying into place...\n"
  sudo cp /var/vagrant/wordpress/wp-config.php /srv/www/wp-config.php
else
  printf "wp-config.php already exists.\n"
fi

