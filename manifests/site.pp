node default {

   file { '/opt/jira':
     ensure => 'directory',
   } ->

  class { 'nginx': } ->

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
  }->

  class { 'postgresql::server': } ->

  deploy::file { 'jdk-7u67-linux-x64.tar.gz':
    target  => '/opt/java',
    url     => 'http://localhost',
    strip   => true,
    require => Class['nginx::service'],
  } ->
  #atlassian-jira-5.1.7.tar.gz
  class { 'jira':
    downloadURL => 'http://localhost/',
    javahome    => '/opt/java',
    version     => '6.4.1',
    proxy       => {
      scheme    => 'http',
      proxyName => $::ipaddress_eth1,
      proxyPort => '80',
    },
    #    staging_or_deploy => 'deploy',
  }

  nginx::resource::vhost { 'all':
    server_name      => [ 'localhost', '127.0.0.1' ],
    www_root         => '/vagrant/files',
  }

  nginx::resource::upstream { 'jira':
    ensure  => present,
    members => [ 'localhost:8080' ],
  }

  nginx::resource::vhost { '192.168.33.10':
    ensure               => present,
    server_name          => [ $::ipaddress_eth1, $::fqdn, $hostname ],
    listen_port          => '80',
    proxy                => 'http://jira',
    proxy_read_timeout   => '300',
    location_cfg_prepend => {
      'proxy_set_header X-Forwarded-Host'   => '$host',
      'proxy_set_header X-Forwarded-Server' => '$host',
      'proxy_set_header X-Forwarded-For'    => '$proxy_add_x_forwarded_for',
      'proxy_set_header Host'               => '$host',
      'proxy_redirect'                      => 'off',
    }
  }

  postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => postgresql_password('jiraadm', 'mypassword'),
  }

}
