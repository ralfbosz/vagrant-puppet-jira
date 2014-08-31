# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "jira1" do |jira1|
    jira1.vm.box      = "centos65"
    jira1.vm.hostname = "jira.home"
    jira1.vm.network :private_network, ip: "192.168.33.10"
    jira1.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
  end
  config.vm.define "jira2" do |jira2|
    jira2.vm.box      = "centos59"
    jira2.vm.hostname = "jira.home"
    jira2.vm.network :private_network, ip: "192.168.33.11"
    jira2.vm.box_url  = "http://puppet-vagrant-boxes.puppetlabs.com/centos-59-x64-vbox4210.box"
  end
  config.vm.define "jira3" do |jira3|
    jira3.vm.box      = "ubuntu1204"
    jira3.vm.hostname = "jira.home"
    jira3.vm.network :private_network, ip: "192.168.33.12"
    jira3.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "site.pp"
    puppet.options = "--verbose"
  end

end
