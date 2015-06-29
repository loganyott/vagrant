# loganyott/vagrant

This is a composer package for pulling in a default Vagrant configuration. Upon installation, it will copy a `Vagrantfile` to your project's root so you can change specific configuration.

# Getting Started

1. `composer require "loganyott/vagrant"`
2. `cp ./vendor/loganyott/vagrant/vagrant.yml ./vagrant.yml`
3. Modify `vagrant.yml` as needed
4. `vagrant up`

# Working with Vagrant

To connect to your vagrant box, `vagrant ssh`.

Any configuration changes made inside the box will persist until a `vagrant provision` or `vagrant destroy`.

# Defaults

Following is a list of default configuration values followed by steps to change them.

## Structure

### Vendor directory
`vendor`

1. Add this to your `composer.json`

    ```json
	{
		"config": {
			"vendor-dir": "DESIRED_VENDOR_DIR"
  		}
	}

### webroot
`/srv/www/`

1. Currently not configurable outside of `vendor`


## Nginx

### Host

`site.local`

1. Open `vagrant.yml`
2. Change

    ```yaml
    :hostname: DESIRED_HOSTNAME

### Nginx port

`8080`

1. Open `vagrant.yml`
2. Change

    ```yaml
	:network:
		:forwarded_port:
			:host: YOUR_DESIRED_PORT

*Note: Vagrant will try to correct port collisions automatically. Look for a line such as `==> default: Fixed port collision for 80 => 8080. Now on port 2200.` during a `vagrant up`. In this example, I can access my local through `localhost:2200`.*

## mySQL

### user
`root`

1. Currently not congiurable outside of `vendor`

### password
`root`

1. Currently not congiurable outside of `vendor`

### database
`project`

1. Currently not congiurable outside of `vendor`

### port
`3306`

1. Currently not congiurable outside of `vendor`
