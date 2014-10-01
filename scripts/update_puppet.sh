#!/bin/bash
if `command apt-get &>/dev/null`; then
  apt-get install --yes lsb-release
  DISTRIB_CODENAME=$(lsb_release --codename --short)
  FILE="puppetlabs-release-${DISTRIB_CODENAME}.deb"
  CREATES="/etc/apt/sources.list.d/puppetlabs.list"
  if [ ! -e /tmp/puppet-updated ]; then
    if [ ! -e $CREATES ]; then
      wget -q http://apt.puppetlabs.com/$FILE
      sudo dpkg -i $FILE
    fi
    sudo apt-get update
    sudo apt-get install --yes puppet
    touch /tmp/puppet-updated
  fi
fi

if `command -v yum &>/dev/null`; then
  DISTRIB_CODENAME=$(cat /etc/redhat-release | awk -Frelease {'print $2'}| awk {'print $1'} | awk -F\. {'print $1'})
  FILE="puppetlabs-release-el-${DISTRIB_CODENAME}.noarch.rpm"
  CREATES="/etc/yum.repos.d/puppetlabs.repo"
  if [ ! -e /tmp/puppet-updated ]; then
    if [ ! -e $CREATES ]; then
      wget -q http://yum.puppetlabs.com/$FILE
      rpm -Uvh $FILE
    fi
    yum -y update puppet
    touch /tmp/puppet-updated
  fi
fi


