# Puppet Master Role
class example42::role::role_puppet {

  class { 'mysql':
    root_password => 'auto',
    template      => 'example42/mysql/my.cnf-puppet',
  }

  class { 'puppetdb':
    db_type      => 'postgresql',
    require      => Class['postgresql'],
  }

  class { 'postgresql':
  }

  class { 'puppetdashboard':
    firewall => false,
    template => 'example42/puppetdashboard/settings.yml',   
  }

  class { 'apache':
    my_class => 'example42::my_apache',
  }

  apache::module { 'proxy': 
    templatefile => 'apache/module/proxy.conf.erb',
  }
  apache::module { 'proxy_http': }

  apache::vhost { '000-default':
    enable => false
  }
  apache::vhost { 'puppetdb.example42.com':
    template => 'example42/apache/vhost/proxy/puppetdb.example42.com.conf',
  }
  apache::vhost { 'dashboard.example42.com':
    template => 'example42/apache/vhost/proxy/dashboard.example42.com.conf',
  }

  # Setup for Puppet Testing
  include rvm
  rvm::system_user { al: }
  rvm_system_ruby { 
    'ruby-1.8.7-head': ensure => present , default_use => true ;
#    'ruby-1.9.2-head': ensure => present , default_use => false ;
#    'ruby-1.9.3-head': ensure => present , default_use => false ;
  }
  rvm_gemset { 'ruby-1.8.7-head@puppet_test': ensure => present , require => Rvm_system_ruby['ruby-1.8.7-head'] }
  rvm_gem { 'ruby-1.8.7-head@puppet_test/puppet': ensure => present , require => Rvm_gemset['ruby-1.8.7-head@puppet_test'] }
  rvm_gem { 'ruby-1.8.7-head@puppet_test/rake': ensure => present , require => Rvm_gemset['ruby-1.8.7-head@puppet_test'] }
  rvm_gem { 'ruby-1.8.7-head@puppet_test/puppet-lint': ensure => present , require => Rvm_gemset['ruby-1.8.7-head@puppet_test'] }
  rvm_gem { 'ruby-1.8.7-head@puppet_test/rspec-puppet': ensure => present , require => Rvm_gemset['ruby-1.8.7-head@puppet_test'] }
  rvm_gem { 'ruby-1.8.7-head@puppet_test/puppet-profiler': ensure => present , require => Rvm_gemset['ruby-1.8.7-head@puppet_test'] }

}
