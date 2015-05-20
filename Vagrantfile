# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Install required plugins if not present.
# @credit hashbangcode/vlad
required_plugins = %w(vagrant-hostsupdater)
required_plugins.each do |plugin|
	need_restart = false
	unless Vagrant.has_plugin? plugin
		system "vagrant plugin install #{plugin}"
		need_restart = true
	end
	exec "vagrant #{ARGV.join(' ')}" if need_restart
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = "ubuntu/trusty64"

	# If true, then any SSH connections made will enable agent forwarding.
	config.ssh.forward_agent = true

	config.vm.provision "shell" do |s|
    # TODO Allow vendor directory to be set/read from outside of Vagrantfile
		s.path = "vendor/loganyott/vagrant/vagrant/provision.sh"
    # Add in arguments for required utilities
    # TODO this in a better way
		s.args = ["wordpress"]
	end

	config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

	# Need set IP for hostsupdater
  # TODO Allow this to be modified outside of Vagrantfile
	config.vm.network "private_network", ip: "192.168.205.10"

	# Access this site via HTTP at this hostname
  # TODO Allow this to be modified outside of Vagrantfile
	config.vm.hostname = "site.local"

	config.vm.provider "virtualbox" do |v|
    # TODO Allow this to be modified outside of Vagrantfile
		v.customize [ "modifyvm", :id, "--memory", "1024" ]
	end
	config.vm.synced_folder ".", "/srv/www", type: "nfs"
  # TODO Allow vendor directory to be set/read from outside of Vagrantfile
	config.vm.synced_folder "vendor/loganyott/vagrant/vagrant", "/var/vagrant", type: "nfs"
end
