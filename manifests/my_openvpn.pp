# = Class: example42::my_openvpn
#
# This is a sample openvpn custom class
# It adds a certificates and custom scripts
#
class example42::my_openvpn {

  # Certificate Files
  file { 'openvpn_server_crt':
    ensure  => present ,
    path    => "${openvpn::config_dir}/${hostname}.crt",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/${hostname}.crt" ,
  }

  file { 'openvpn_server_key':
    ensure  => present ,
    path    => "${openvpn::config_dir}/${hostname}.key",
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/${hostname}.key" ,
  }

  file { 'openvpn_client_crt':
    ensure  => present ,
    path    => "${openvpn::config_dir}/${hostname}_client.crt",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/${hostname}_client.crt" ,
  }

  file { 'openvpn_client_key':
    ensure  => present ,
    path    => "${openvpn::config_dir}/${hostname}_client.key",
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/${hostname}_client.key" ,
  }

  file { 'openvpn_ca_crt':
    ensure  => present ,
    path    => "${openvpn::config_dir}/ca.crt",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/ca.crt" ,
  }

  file { 'openvpn_dh':
    ensure  => present ,
    path    => "${openvpn::config_dir}/dh1024.pem",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/dh1024.pem" ,
  }

  file { 'openvpn_client_connect':
    ensure  => present ,
    path    => "${openvpn::config_dir}/client_connect.sh",
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/client_connect.sh" ,
  }

  file { 'openvpn_client_disconnect':
    ensure  => present ,
    path    => "${openvpn::config_dir}/client_disconnect.sh",
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/client_disconnect.sh" ,
  }

  file { 'openvpn_ccd':
    ensure  => directory ,
    path    => "${openvpn::config_dir}/ccd",
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/example42/openvpn/ccd" ,
    recurse => true,
  }

}
