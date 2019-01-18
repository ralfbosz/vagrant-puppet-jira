node default {

  $_javahome = $facts['os']['family'] ? {
    'RedHat' => '/usr/java/default',
    'Debian' => '/usr/lib/jvm/jdk1.8.0_201',
  }

  java::oracle { 'jdk8' :
    ensure        => 'present',
    version       => '8',
    version_major => '8u201',
    version_minor => 'b09',
    url_hash      => '42970487e3af4f5aa5bca3f542482c60',
    java_se       => 'jdk',
  }

  -> class { '::nginx': }

  -> class { '::postgresql::globals':
    manage_package_repo => true,
    version             => '9.5',
  }

  -> class { '::postgresql::server': }

  -> postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => postgresql_password('jiraadm', 'mypassword'),
  }

  -> class { '::jira':
    javahome => $_javahome,
    version  => '7.13.0',
    jvm_xms  => '384m',
  }

  include ::jira::facts

  include ::nginx

  nginx::resource::server { "jira.home":
    listen_port => 80,
    proxy       => 'http://localhost:8080',
  }

}
