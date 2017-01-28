# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.4.0"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
  config.vm.provision :shell, :path => "./.vagrant_puppet/init.sh"
  config.vm.provision :puppet do |puppet|
    puppet.options = "--verbose --debug"
    puppet.working_directory = "/vagrant/"
    puppet.environment = "production"
    puppet.environment_path = "/Users/uweerd3/devs/puppet-repos/vpc_creation/environments"
  end
end
