# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end

  config.vm.define "jira1" do |jira1|
    jira1.vm.box = "centos/7"
    jira1.vm.hostname = "jira.home"
    jira1.vm.network :private_network, ip: "192.168.33.10"
  end

  config.vm.define "jira2" do |jira2|
    jira2.vm.box = "centos/6"
    jira2.vm.hostname = "jira.home"
    jira2.vm.network :private_network, ip: "192.168.33.11"
  end

  config.vm.define "jira3" do |jira3|
    jira3.vm.box = "ubuntu/xenial64"
    jira3.vm.hostname = "jira.home"
    jira3.vm.network :private_network, ip: "192.168.33.12"
  end

  config.vm.provision "shell", path: "scripts/install-puppet.sh"
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "site.pp"
  end

end
