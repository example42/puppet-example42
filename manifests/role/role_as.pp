# Application Server Role
class example42::role::role_as {

  include java

  # Apache
  class { 'apache':
    my_class => 'example42::my_apache',
    template => 'example42/apache/apache.conf-as',
  }
  apache::module { 'headers': }
  apache::module { 'rewrite': }
  apache::module { 'proxy': }
  apache::module { 'proxy_http': }
  apache::module { 'proxy_html':
    install_package => $::osfamily ? {
      debian => 'libapache2-mod-proxy-html',
      redhat => 'mod_proxy_html',
    },
  }

  ## Jboss
  class { 'jboss':
    version              => '7',
    process_user         => 'jboss',
    bindaddr             => '0.0.0.0',
    user_uid             => '1500',
    user_gid             => '1500',
  }

  # Deploy of example42.ear on Jboss
  puppi::project::war { 'example42':
    source           => $::env ? {
      devel => 'http://deploy.example42.com/latest/example42.ear' ,
      test  => 'http://deploy.example42.com/test/example42.ear' ,
      prod  => 'http://deploy.example42.com/prod/example42.ear' ,
    },
    deploy_root      => '/opt/jboss/standalone/deployments/' ,
    user             => 'jboss' ,
    backup_retention => 3 ,
    report_email     => 'roots@example42.com',
    check_deploy     => false,
  }

  # Application monitoring
  include example42::monitor::as

  # Jenkins deploys via sudo
  User <| tag == deployers |>
  Group <| tag == deployers |>

  class { 'sudo':
    source => 'puppet:///modules/example42/sudo/sudoers',
  }
  sudo::directive { 'jenkins':
    content => "jenkins ALL=NOPASSWD: /usr/sbin/puppi \n",
  }

}
