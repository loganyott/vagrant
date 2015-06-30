# Drupal Config
# Install Drush
printf "Checking for Drush\n"
if [ ! -f /srv/www/vendor/bin/drush ]; then
  printf "Drush not found. Installing...\n"
  ../composer/composer.sh
  composer require --dev drush/drush
  cp /srv/www/vendor/drush/drush/drush.complete.sh /etc/bash_completion.d/drush
else
  printf "Drush already installed.\n"
fi 

