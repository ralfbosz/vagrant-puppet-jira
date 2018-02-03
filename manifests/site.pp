node default {

  $_javahome = $facts['os']['family'] ? {
    'RedHat' => '/usr/java/default',
    'Debian' => '/usr/lib/jvm/jdk1.8.0_131',
  }

  java::oracle { 'jdk8' :
    ensure        => 'present',
    version       => '8',
    version_major => '8u131',
    version_minor => 'b11',
    url_hash      => 'd54c1d3a095b4ff2b6607d096fa80163',
    java_se       => 'jdk',
  }

  -> class { '::nginx': }

  -> class { '::postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
  }

  -> class { '::postgresql::server': }

  -> postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => postgresql_password('jiraadm', 'mypassword'),
  }

  -> class { '::jira':
    javahome => $_javahome,
    version  => '7.7.1',
  }

  include ::jira::facts

  include ::nginx

  nginx::resource::server { "jira.home":
    listen_port => 80,
    proxy       => 'http://localhost:8080',
  }

}
