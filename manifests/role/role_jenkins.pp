# Jenkins Role
class example42::role::role_jenkins {

  include yum::repo::jpackage6
  package { 'java-1.6.0-openjdk': ensure => present }
  package { 'java-1.6.0-openjdk-devel': ensure => present }
  package { 'git': ensure => present }
  package { 'ant': ensure => present }

  class { 'jenkins':
  }

  class { 'maven::maven':
    version => '3.0.4',
  }

  class { 'apache':
  }

  apache::vhost { 'deploy.example42.conf':
    docroot  => '/var/www/html/deploy',
    template => 'example42/apache/vhost/deploy.example42.com.conf',
  }

}
