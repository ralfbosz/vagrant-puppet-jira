#!/bin/bash
if [ -f /usr/bin/rpm ];then
  rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
  yum install puppet-agent -y
elif [ -f /usr/bin/dpkg ];then
  cd /tmp
  wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
  dpkg -i puppet5-release-xenial.deb
  apt update
  apt install puppet-agent -y
fi
export PATH=$PATH:/opt/puppetlabs/bin
puppet module install puppetlabs-stdlib
puppet module install puppetlabs-java
puppet module install puppetlabs-postgresql
puppet module install puppetlabs-apt
puppet module install puppet-jira
puppet module install puppet-stash
puppet module install puppet-confluence
puppet module install puppet-nginx
