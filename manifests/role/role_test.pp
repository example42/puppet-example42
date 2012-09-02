class example42::role::role_test {

  class { 'logstash': }
        logstash::config { 'local_search':
          template => 'logstash/config/local_search.erb',
        }

#  class { 'vagrant': }

#  vagrant::environment { 'example42':
#    user => 'example42',
#  }
#  vagrant::vm { 'test_lenny64':
#    environment => 'example42',
#    box         => 'debian_lenny_64',
#    box_url     => 'http://puppetlabs.s3.amazonaws.com/pub/debian_lenny_64.box'
#  }
#  vagrant::vm { "test_lucid64":
#      environment => "example42" ,
#      box => "lucid64" ,
#      box_url => "http://files.vagrantup.com/lucid64.box"
#  }

      class { 'mcollective':
        stomp_host           => 'mq.example42.com',
        stomp_user           => 'mcollective',
        stomp_password       => 'private_server',
        stomp_admin          => 'admin',
        stomp_admin_password => 'private_client',
        psk                  => 'aSecretPreSharedKey',
        install_client       => $::role ? {
          mco     => true,
          default => false,
        },
        install_stomp_server => $::role ? {
          mq      => true,
          default => false,
        },
        absent => true,
     }
}
