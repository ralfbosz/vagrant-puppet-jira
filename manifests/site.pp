node default {

  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
  }

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
    javahome => '/usr/java/default',
    version  => '7.7.1',
  }

  include ::jira::facts

}
