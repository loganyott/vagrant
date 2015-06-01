# -*- mode: ruby -*-
# vi: set ft=ruby :

require "fileutils"
require "yaml"
require "json"

# Vagrantfile API/syntax version. Don"t touch unless you know what you"re doing!
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
	exec "vagrant #{ARGV.join(" ")}" if need_restart
end

# Load settings from vagrant.yml
pconfig = "vagrant.yml"
pconfig = File.exists?(pconfig) ? YAML.load_file(pconfig) : Hash.new

# Configure Time
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = pconfig[:box] || "ubuntu/trusty64"

	# If true, then any SSH connections made will enable agent forwarding.
	config.ssh.forward_agent = pconfig.key?(:ssh) && pconfig[:ssh].key?(:forward_agent) ? pconfig[:ssh][:forward_agent] : true

	config.vm.provision "shell" do |s|
    # Specify provison script
    s.path = File.join(File.dirname(__FILE__), "vagrant/provision.sh")
  end

  if pconfig.key?(:include)
    includes = pconfig[:include]
    pconfig[:include].each do |include|
      config.vm.provision "shell" do |s|
        s.path = File.join(File.dirname(__FILE__), "vagrant/#{include}/#{include}.sh");
      end
    end
	end

  pconfig.key?(:network) || pconfig[:network] = Hash.new
  network = pconfig[:network]
    network.key?(:forwarded_port) || network[:forwarded_port] = Hash.new
    forwarded_port = network[:forwarded_port]
      forwarded_port.key?(:guest) || forwarded_port[:guest] = 80
      forwarded_port.key?(:host) || forwarded_port[:host] = 8080
      forwarded_port.key?(:auto_correct) || forwarded_port[:auto_correct] = true
    network.key?(:ip) || network[:ip] = "192.168.205.10"  

	  config.vm.network "forwarded_port", 
      guest: forwarded_port[:guest],
      host: forwarded_port[:host],
      auto_correct: forwarded_port[:auto_correct]

  	# Need set IP for hostsupdater
    # TODO https://github.com/smdahlen/vagrant-hostmanager/issues/86#issuecomment-72571273
    config.vm.network "private_network",
      ip: network[:ip]

	# Access this site via HTTP at this hostname
  # TODO Add this to a bin configurator
	config.vm.hostname = pconfig[:hostname] || "site.local"

  # Add any aliases for hostname
  # TODO Add this to a bin configurator
  if pconfig.key?(:aliases) && pconfig[:aliases].kindof?(Array)
    config.hostsupdater.aliases = pconfig[:aliases]
  end

	config.vm.provider "virtualbox" do |v|
    # TODO Add this to a bin configurator
    # TODO Allow this to be set/read from outside of Vagrantfile
    pconfig.key?(:memory) || pconfig[:memory] = "1024"
		v.customize [ "modifyvm", :id, "--memory", pconfig[:memory] ]
	end

  # TODO Add this to a bin configurator
  pconfig.key?(:folder_type) || pconfig[:folder_type] = "nfs"

  # TODO Add this to a bin configurator
  pconfig.key?(:docroot) || pconfig[:docroot] = "."
  config.vm.synced_folder pconfig[:docroot], "/srv/www", type: pconfig[:folder_type]

  # TODO Add this to a bin configurator
  composer = JSON.parse(File.read("composer.json"))
  composer.key?("config") || composer["config"] = Hash.new
  composer["config"].key?("vendor-dir") || composer["config"]["vendor-dir"] = "vendor"
    config.vm.synced_folder File.join( composer["config"]["vendor-dir"], "loganyott/vagrant/vagrant" ), "/var/vagrant", type: pconfig[:folder_type]
end
