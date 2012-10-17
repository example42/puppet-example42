# Example42 general class
# The resources defined here are applied to ALL servers
class example42 {

  ### USERS MANAGEMENT (quick approach)
  include example42::users # Here are defined (but not applied) all users
  
  # Users and groups "realized" on every nodes
  User <| title == root |> # Root Password management
  User::Managed <| tag == admins |> 
  User::Managed <| tag == developers |> 
  Group <| tag == admins |>
  Group <| tag == developers |> 

  # OpenSSH custom template
  class { 'openssh': 
    template => 'example42/openssh/sshd_config.erb',
  }

  # Vim with pathogen for all
  class { 'vim':
  }
  vim::userconfig { 'example42':
    install_pathogen => true,
  }

  # DNS configuration
  class { 'resolver': 
    dns_servers => [ '8.8.4.4' , '8.8.8.8' ],
    search      => 'example42.com' , 
    options     => {
      'rotate'  => '',
      'timeout' => '2',
    },
  }

  # Quick /etc/hosts
  file { '/etc/hosts':
    ensure   => present ,
    content  => template('example42/hosts/hosts.erb'),
  }

  # Puppet Client / server configuration
  class { 'puppet':
    server          => 'puppet.example42.com',
    # postrun_command => '/usr/bin/mailpuppicheck -m roots@example42.com -r 2',
    allow        => ['127.0.0.1','*'],
    mode         => $::role ? {
      'puppet' => 'server',
      default  => 'client',
    },
    runmode      => 'manual',
    # nodetool     => 'dashboard',
    db           => 'puppetdb',
    db_server    => 'puppet',
    db_port      => '8081',
  }

  # Mcollective Infrastructure
  # Stomp server is mq.example42.com
  # Mcollective Client is on the PuppetMaster
  class { 'mcollective':
    stomp_host           => 'mq.example42.com',
    stomp_user           => 'mcollective',
    stomp_password       => 'private_server',
    stomp_admin          => 'admin',
    stomp_admin_password => 'private_client',
    psk                  => 'aSecretPreSharedKey',
    install_client       => $::role ? {
      'puppet'     => true,
      default     => false,
    },
    install_stomp_server => $::role ? {
      mq      => true,
      default => false,
    },
  }



  # NTP synced via cron ntpdate
  class { 'ntp':
    runmode => 'cron',
  }

  # Disabling unneeded services (quick way)
  case $::operatingsystem {
    /(?i:RedHat|CentOS|Scientific|Amazon|Linux)/: {
      service { 'cgconfig': ensure => stopped , enable => false }
      service { 'iscsi': ensure => stopped , enable => false }
      service { 'iscsid': ensure => stopped , enable => false }
      service { 'netfs': ensure => stopped , enable => false }
      service { 'nfslock': ensure => stopped , enable => false }
      service { 'rpcbind': ensure => stopped , enable => false }
      service { 'rpcgssd': ensure => stopped , enable => false }
      service { 'rpcidmapd': ensure => stopped , enable => false }
    }
    default: {}
  }

  # MUNIN (Server is called munin or mon and has address 10.42.42.36)
  class { 'munin':
    server       => [ '10.42.42.36' ] ,
    server_local => $::hostname ? {
      'munin' => true,
      'mon'   => true,
      default => false,
    },
  }

  # Quick yum repos management for Centos6
  case $::operatingsystem {
    /(?i:RedHat|CentOS|Scientific|Amazon|Linux)/: {
      class { 'yum':
        extrarepo => [ 'epel' , 'puppet' ],
#        clean_repos => true,
      }
    }
    default: {}
  }
  
  # Include Role classes ($role variable must be set at top scope)
  include "example42::role::role_${::role}"

}
