# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require 'yaml'
require 'json'

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

# Load settings from vagrant.yml
pconfig = File.join(File.dirname(__FILE__), "vagrant.yml")
pconfig = File.exists?(CONFIG) ? YAML.load_file(CONFIG) : nil

# Configure Time
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = defined?(pconfig.box) ? pconfig.box : "ubuntu/trusty64"

	# If true, then any SSH connections made will enable agent forwarding.
	config.ssh.forward_agent = defined?(pconfig.ssh.forward_agent) ? pconfig.ssh.forward_agent : true

	config.vm.provision "shell" do |s|
    # Specify provison script
    s.path = File.join(File.dirname(__FILE__), "vagrant/provision.sh")

    # Add in arguments for required utilities
    # TODO this in a better way
    if defined?(pconfig.include)
      s.args = []
      pconfig.include.each do |include|
        s.args << include
      end
    end
	end

	config.vm.network "forwarded_port", 
    guest: defined?(pconfig.network.forwarded_port.guest) ? pconfig.network.guest : 80, 
    host: defined?(pconfig.network.forwarded_port.host) ? pconfig.network.host : 8080, 
    auto_correct: defined?(pconfig.network.forwarded_port.auto_correct) ? pconfig.network.autocorrect : true

	# Need set IP for hostsupdater
  # TODO https://github.com/smdahlen/vagrant-hostmanager/issues/86#issuecomment-72571273
  if defined?(pconfig.network.type) && (pconfig.network.type == "dhcp")
    config.vm.network pconfig.network.type
  else
    config.vm.network pconfig.network.type,
      ip: defined?(pconfig.network.ip) ? pconfig.network.ip : "192.168.205.10"
  end
 
	# Access this site via HTTP at this hostname
  # TODO Add this to a bin configurator
	config.vm.hostname = defined?(pconfig.hostname) ? pconfig.hostname : "site.local"

  # Add any aliases for hostname
  # TODO Add this to a bin configurator
  if defined?(pconfig.aliases) && pconfig.aliases.kindof?(Array)
    config.hostsupdater.aliases = pconfig.aliases
  end

	config.vm.provider "virtualbox" do |v|
    # TODO Add this to a bin configurator
    # TODO Allow this to be set/read from outside of Vagrantfile
		v.customize [ "modifyvm", :id, "--memory", "1024" ]
	end

  # TODO Add this to a bin configurator
  synced_folder = { "type": "" }
  synced_folder.type = defined?(pconfig.folder_type) ? pconfig.folder_type : "nfs"

  # TODO Add this to a bin configurator
  if defined?(pconfig.docroot)
    config.vm.synced_folder pconfig.docroot, "/srv/www", type: synced_folder.type
  else
	  config.vm.synced_folder ".", "/srv/www", type: synced_folder.type
  end

  # TODO Add this to a bin configurator
  composer = JSON.parse(File.read('composer.json'))
  if defined?(composer['config']['vendor-dir'])
    config.vm.synced_folder File.join( composer['config']['vendor-dir'], "loganyott/vagrant/vagrant" ), "/var/vagrant", type: synced_folder.type
  else
	  config.vm.synced_folder "vendor/loganyott/vagrant/vagrant", "/var/vagrant", type: "nfs"
  end
end
