class example42::role::role_latest {

  User <| tag == deployers |> 
  Group <| tag == deployers |> 
  class { 'sudo':
    source => 'puppet:///modules/example42/sudo/sudoers',
  }
  sudo::directive { 'jenkins':
    content => "jenkins ALL=NOPASSWD: /usr/sbin/puppi \n",
  }

  package { 'git': ensure => present }

  include java



  ## Apache 
  class { 'apache':
#    template => 'example42/apache/apache.conf-latest',
  }

  apache::vhost { 'latest.example42.com':
    docroot        => "${apache::data_dir}" ,
    docroot_create => true,
    template       => 'example42/apache/vhost/latest.example42.com.conf',
  }

  include example42::role::service_as
  include example42::role::service_clientdb
  include example42::role::service_gsdb

}
