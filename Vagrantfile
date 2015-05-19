# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # If true, then any SSH connections made will enable agent forwarding.
  config.ssh.forward_agent = true

  config.vm.provision "shell", path: "vendor/loganyott/vagrant-installer/vagrant/provision.sh"
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "private_network", ip: "192.168.205.10"
  config.vm.provider "virtualbox" do |v|
    v.customize [ "modifyvm", :id, "--memory", "1024" ]
  end
  config.vm.synced_folder ".", "/srv/www", id: "vagrant-root",
    type: "nfs"
end
