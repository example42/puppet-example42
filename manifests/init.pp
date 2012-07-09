# Example42 general class
# The resources defined here are applied to ALL servers
class example42 {

  ### USERS MANAGEMENT (quick approach)
  include example42::users # Here are defined (but not applied) all users
  # Users and groups "realized" on every nodes
  User <| title == root |> # Root Password management
  User <| tag == admins |> 
  User <| tag == developers |> 
  Group <| tag == admins |>
  Group <| tag == developers |> 

  # OpenSSH custom template
  class { 'openssh': 
    template => 'example42/openssh/sshd_config.erb',
  }

  # DNS configuration
  class { 'resolver': 
    dns_servers => [ '8.8.4.4' , '8.8.8.8' ],
    search      => 'example42.com' , 
    options     => {
      'rotate'  => '',
      'timeout' => '2',
    },
    firewall => false,
  }

  # Quick /etc/hosts
  file { '/etc/hosts':
    ensure   => present ,
    content  => template('example42/hosts/hosts.erb'),
  }

  # Puppet 
  # Calculated random times for puppetruns via cron (every 3 hours)
  $rand_minute = fqdn_rand(60)
  $rand_hour = fqdn_rand(3)
  $rand_hour_set = $rand_hour ? {
    '0' => '0,3,6,9,12,15,18,21',
    '1' => '1,4,7,10,13,16,19,22',
    '2' => '2,5,8,11,14,17,20,23',
    default => '*', # This should never be met
  }
  $puppet_cron = "$rand_minute $rand_hour_set * * *"

  # Client / server configuration
  class { 'puppet':
    server       => 'puppet.example42.com',
    runmode      => 'cron',
    croninterval => $puppet_cron,
    croncommand  => '/usr/bin/puppet agent --onetime --ignorecache --no-usecacheonfailure',
    postrun_command => '/usr/bin/mailpuppicheck -m roots@example42.com -r 2',
    allow        => ['127.0.0.1','*'],
    mode         => $role ? {
      'puppet' => 'server',
      default  => 'client',
    },
    nodetool     => 'dashboard',
    db           => 'puppetdb',
    db_server    => 'puppet',
    db_port      => '8081',
    firewall     => false,
  }

  # NTP synced via cron ntpdate
  class { 'ntp':
    runmode => 'cron',
  }

  # Disabling unneeded services (quick way)
  case $::operatingsystem {
    'centos': {
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
    'centos': {
      class { 'yum':
        clean_repos => true,
      }
    }
    default: {}
  }
  
  # Include Role classes ($role variable must be set at top scope)
  include "example42::role::role_${::role}"

}
