class example42::role::role_openvpn {

  # OpenVPN Basic Setup
  class { 'openvpn':
    my_class => 'example42::my_openvpn',
  }

  ### OpenVpn Tunnel: Server
  openvpn::tunnel { "server":
    port         => '1194',
    server       => "10.220.0.0 255.255.255.0",
    push         => "10.42.42.0 255.255.255.0",
    template     => 'example42/openvpn/server.conf.erb',
  }

}
