# loganyott/vagrant

This is a composer package for pulling in a default Vagrant configuration. Upon installation, it will copy a `Vagrantfile` to your project's root so you can change specific configuration.

# Getting Started

1. `composer require "loganyott/vagrant"`
2. `vagrant up`

# Working with Vagrant

To connect to your vagrant box, `vagrant ssh`.

Any configuration changes made inside the box will persist until a `vagrant provision` or `vagrant destroy`.

Shipped with box:
1. Nginx
2. PHP-FPM
3. mySQL
4. WP-CLI

# Defaults

## Structure

### Vendor directory
`vendor`

To change:
  1. Open Vagrantfile
  2. Find this line: `config.vm.provision "shell", path: "vendor/loganyott/vagrant/vagrant/provision.sh"`
  3. Change `vendor` to your vendor directory

### webroot
`/srv/www/`

To change:
  Currently not configurable outside of `vendor`

## Nginx

### Nginx host
`localhost`

To change:
  Currently not configurable in Vagrantfile

### Nginx port
`8080`

To change:
  1. Open Vagrantfile
  2. Find this line: `config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true`
  3. Change `8080` to desired port.
  4. `vagrant reload`

*Note: Vagrant will try to correct port collisions automatically. Look for a line such as `==> default: Fixed port collision for 80 => 8080. Now on port 2200.` during a `vagrant up`. In this example, I can access my local through `localhost:2200`.*

## mySQL

### user
`root`

To change:
  Currently not congiurable outside of `vendor`

### password
`root`

To change:
  Currently not congiurable outside of `vendor`

### database
`project`

To change:
  Currently not congiurable outside of `vendor`

### port
`3306`

To change:
  Currently not congiurable outside of `vendor`
