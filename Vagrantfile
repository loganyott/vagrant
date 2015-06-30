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
# Intialize env for output later
env = Hash.new


# Configure Time
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## Startup Configuration
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = env[:BOX] = pconfig[:box] || "ubuntu/trusty64"

  # If true, then any SSH connections made will enable agent forwarding.
  config.ssh.forward_agent = pconfig.key?(:ssh) && pconfig[:ssh].key?(:forward_agent) ? pconfig[:ssh][:forward_agent] : true


  ## Configuration
  pconfig.key?(:network) || pconfig[:network] = Hash.new
  network = pconfig[:network]
    # TODO network should probably be able to handle more ports
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
  config.vm.hostname = env[:HOSTNAME] = pconfig[:hostname] || "site.local"

  # Add any aliases for hostname
  # TODO Add this to a bin configurator
  if pconfig.key?(:aliases) && pconfig[:aliases].respond_to?(:each)
    config.hostsupdater.aliases = pconfig[:aliases]
  end

  # TODO Add this to a bin configurator
  pconfig.key?(:folder_type) || pconfig[:folder_type] = "nfs"
  config.vm.synced_folder VROOT, "/srv/www", type: pconfig[:folder_type]

  # TODO Add this to a bin configurator
  composer = File.exists?("composer.json") ? JSON.parse(File.read("composer.json")) : Hash.new
  composer.key?("config") || composer["config"] = Hash.new
  composer["config"].key?("vendor-dir") || composer["config"]["vendor-dir"] = "vendor"
    env[:VENDOR_DIR] = composer["config"]["vendor-dir"]
    config.vm.synced_folder File.join( composer["config"]["vendor-dir"], "loganyott/vagrant/vagrant" ), "/var/vagrant", type: pconfig[:folder_type]


  ## Providers
  config.vm.provider "virtualbox" do |v|
    # TODO Add this to a bin configurator
    # TODO Allow this to be set/read from outside of Vagrantfile
    pconfig.key?(:memory) || pconfig[:memory] = 1024
    v.customize [ "modifyvm", :id, "--memory", pconfig[:memory] ]
  end


  ## Export our environment variables

  # TODO Add this to a bin configurator
  pconfig.key?(:docroot) || pconfig[:docroot] = ""
  env[:DOCROOT] = "/srv/www/#{pconfig[:docroot]}"

  File.open( File.join( VROOT, ".env" ), "a+" ) { |f|
    contents = File.read(f);
    env.each do |k, v|
      line = "export #{k.upcase}=#{v}"
      contents.include?(line) || f.puts(line)
    end
    # Try to explicitly close file so it is available for provisioner
    f.close
  }


  ## Provisioning
  # Include-agnostic script
  config.vm.provision "shell" do |s|
    s.path = File.join(File.dirname(__FILE__), "vagrant/provision.sh")
  end

  # Includes
  # TODO These should probably be rewritten in Ruby so they can do cooler stuff
  if pconfig.key?(:include)
    includes = pconfig[:include]
    pconfig[:include].each do |include|
      config.vm.provision "shell" do |s|
        s.path = File.join(File.dirname(__FILE__), "vagrant/#{include}/#{include}.sh");
      end
    end
  end
end
